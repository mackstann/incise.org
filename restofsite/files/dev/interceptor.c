/* This Firefox hack was written by Nick Welch <mack@incise.org> in 2006.
 *
 * This software is in the public domain
 * and is provided AS IS, with NO WARRANTY.
 */

/* command line usage:
  
$ gcc interceptor.c -o interceptor.so -shared -lX11 -ldl -rdynamic
$ LD_PRELOAD=./interceptor.so
$ firefox &
(... look at messages if you want to ...)
$ exit

*/

#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>

/* anyone know a better way to call the real XRaiseWindow than using dl stuff?*/

static void * libX11;
static int (* real_x_raise_window)(Display *, Window);

void __attribute__((constructor)) init(void)
{
    libX11 = dlopen("libX11.so", RTLD_LAZY);
    if(libX11)
    {
        *(void **) (&real_x_raise_window) = dlsym(libX11, "XRaiseWindow");
        dlerror();
        char * error;
        if((error = dlerror()) != NULL)
        {
            fprintf(stderr, "ERROR - dlsym - %s\n", error);
            real_x_raise_window = 0x0;
        }
    }
    else
        fprintf(stderr, "ERROR - dlopen - couldn't open libX11.so\n");
}

void __attribute__((destructor)) fini(void)
{
    if(libX11)
        dlclose(libX11);
}

void msg(const char * doing, Window w,
        unsigned width, unsigned height, XClassHint * cls)
{
    fprintf(stderr,
        "%s XRaiseWindow - window 0x%08lx - name: %s, class: %s, "
        "width: %4u, height: %4u\n",
        doing, (unsigned long)w,
        cls->res_name ? cls->res_name : "<NULL>",
        cls->res_class ? cls->res_class : "<NULL>",
        width, height

    );
}

int call_real_x_raise_window(Display * dpy, Window w)
{
    if(libX11 && real_x_raise_window)
        (*real_x_raise_window)(dpy, w);
}

int XRaiseWindow(Display * dpy, Window w)
{
    int x, y;
    unsigned width, height, border_width, depth;
    Window root;
    XGetGeometry(dpy, w, &root,  
            &x, &y,              
            &width, &height,     
            &border_width, &depth);

    XClassHint * cls = XAllocClassHint();
    XGetClassHint(dpy, w, cls);

    if
    (
        // decent heuristic for me.  would break on a very small browser window.
        width > 400 && height > 400 &&
        cls->res_name && cls->res_class &&
        !strcmp(cls->res_name, "Gecko") &&
        !strcmp(cls->res_class, "Firefox-bin")
    )
    {
        msg("BLOCKING", w, width, height, cls);
        return 0;
    }

    msg("ALLOWING", w, width, height, cls);
    return call_real_x_raise_window(dpy, w);
}


#include <wchar.h>

#include <FL/Fl.H>
#include <FL/Fl_Double_Window.H>
#include <Fl/Fl_Button.h>
#include <FL/Fl_Box.H>
#include <Fl/Fl_Device.h>

#include <Fl/Fl_JPEG_Image.H>
#include <Fl/Fl_File_Browser.H>

#include <FL/fl_ask.H> // fl_ask

#define MAX_LEN 256

void my_callback(Fl_Widget*, void*);
void opendir_cb(Fl_Widget *, void *);

int main(int argc, char **argv)
{
  Fl_Double_Window *window = new Fl_Double_Window(500, 308, "图片标记");
  //  window->icon((const void *)LoadIcon(fl_display, MAKEINTRESOURCE(101)));

  wchar_t wcs[MAX_LEN] = L"打开目录";
  char utf8[MAX_LEN] = {0};
  fl_utf8fromwc(utf8, MAX_LEN, wcs, wcslen(wcs));

  Fl_Button   btn(15, 10, 80, 30, utf8);
  btn.shortcut("CTRL+O");
  btn.callback(opendir_cb);

  Fl_File_Browser fb(10, 50, 100, 248);
  wchar_t img_name[MAX_LEN] = L"/Users/jiya/Desktop/demo/00102.jpg";
  char utf8_name[MAX_LEN] = {0}; 
  fl_utf8fromwc(utf8_name, MAX_LEN, img_name, wcslen(img_name));

  Fl_JPEG_Image img(utf8_name);

  Fl_Box box(120,10, 352, 288);     // widget that will contain image
  box.image(img);

  window->callback(my_callback);
  /***************************************************************
        进入FLTK的事件循环处理过程
  ***************************************************************/
  window->end();

  window->show(argc, argv);
  // Fl::visual(FL_RGB);

  return Fl::run();
}


void my_callback(Fl_Widget*, void*) {
  if (fl_ask("Are you sure you want to quit?"))
    exit(0);
}

void opendir_cb(Fl_Widget *, void *) {
  fl_ask("demo");
}

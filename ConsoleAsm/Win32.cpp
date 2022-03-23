
#include <iostream>
#include <Windows.h>
#include <stdlib.h>

// Right click at the project name > Build Dependencies > Build Customizations Select the "masm", then OK.
// file build item type microsoft micro assembler

// This file contain all Win32 API methods with a simple wrapper for our usage.
// It's calling conventions set to be wrapped easily with the asm functions.


// Global, do once
HANDLE hConsole_c = GetStdHandle(STD_OUTPUT_HANDLE);


// Print a single character
extern "C"
void __cdecl printCharWin32(
    int x,      /* X location */
    int y,      /* Y location */
    wchar_t c,  /* Character to print */
    WORD color = 0x0007 /* Color + attributes */)
{
    COORD loc{ SHORT(x),SHORT(y) };
    DWORD dwBytesWritten = 0;
    WriteConsoleOutputAttribute(hConsole_c, &color, 1, loc, &dwBytesWritten);
    WriteConsoleOutputCharacter(hConsole_c, &c, 1,  loc, &dwBytesWritten);
}





extern "C"
void __cdecl printPixelWin32(
    int x,      /* X location */
    int y,      /* Y location */
    int rgb)
{
    //Get a console handle
    HWND myconsole = GetConsoleWindow();

    //Get a handle to device context
    HDC mydc = GetDC(myconsole);

    //Choose any color
    COLORREF COLOR = rgb;

    //Draw pixels
    SetPixel(mydc, x, y, COLOR);
    ReleaseDC(myconsole, mydc);
}

// Print a string (as const char*)
extern "C"
void __cdecl printStrWin32(
    int x,      /* X location */
    int y,      /* Y location */
    const char* str,  /* string to print */
    WORD color = 0x0007 /* Color + attributes */)
{
    COORD loc{ SHORT(x),SHORT(y) };
    DWORD dwBytesWritten = 0;
    const int MAX_SIZE(100);
    wchar_t wtext[MAX_SIZE+1];
    auto len = strlen(str);
    if (len > MAX_SIZE) len = MAX_SIZE;
    size_t _PtNumOfCharConverted;
    mbstowcs_s(&_PtNumOfCharConverted,wtext, len+1, str, len+1);
    WriteConsoleOutputAttribute(hConsole_c, &color, 1, loc, &dwBytesWritten);
    WriteConsoleOutputCharacter(hConsole_c, wtext, len, loc, &dwBytesWritten);
}

// Get a single character. 
extern "C"
WORD __cdecl getCharWin32()
{
    return _getwch();
}

extern "C"
int mainAsm();

int main()
{
    printPixelWin32(1, 2, 0xffffff);

    return mainAsm();
}
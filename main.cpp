#include <stdio.h>
#include <iostream>
#include <fstream>
#include "subprocess.hpp"

using namespace std;

int main(int argc, char *argv[])
{
    subprocess::popen cmd("ls", {});
    std::cout << cmd.stdout().rdbuf();
    cout << "salam" << endl;
    
    return 0;
}
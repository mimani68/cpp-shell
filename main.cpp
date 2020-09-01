#include <stdio.h>
#include <fstream>
#include "subprocess.hpp"


int main(int argc, char *argv[])
{
    subprocess::popen cmd("ls", {});
    std::cout << cmd.stdout().rdbuf();
    
    return 0;
}
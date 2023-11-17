#include<iostream>
#include<cstdio>
#include<map>
#include<sstream>
using namespace std;

#define MAX 1000000
map<string, string>M;
char line[MAX];

int main()
{
    string string1, string2;
	//lee desde teclado
    while(gets(line))
    {
        if(line[0]=='\0') break;
        stringstream ss(line);
        ss >> string1;
        ss >> string2;
        M[string2] = string1;
    }
    string string3;
    while(cin >> string3)
    {
        if(M[string3].length()==0)
        {
          cout << "eh" << endl;
        }
        else
        {
          cout << M[string3] <<endl;
        }
    }
    return 0;
}


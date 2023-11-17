#include<bits/stdc++.h>
#include<stdio.h>
#include<string.h>
#include<math.h>
#include<algorithm>
#include<map>
#include<vector> 
using namespace std;

int n;
map<int, int> m;
vector<int> v;

int main() {

	//mientras reciba enteros 
    while(scanf("%d", &n) == 1) {
		//si ese numero no existe en el map no esta repetido
		//entonces se pushea al final del vector el valor ingresado
        if(m[n] == 0) 
    		v.push_back(n);
        m[n]++;
		
    }

    for(int i = 0; i < v.size(); i++) {
		//muestra el numero y la cantidad de veces que se repitio
        printf("%d %d\n", v[i], m[v[i]]);

    }

}
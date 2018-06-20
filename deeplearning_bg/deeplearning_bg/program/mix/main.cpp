#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>

using namespace std;

int main()
{
    ifstream infile("files.txt");

    string categray, videos;
    string Re, Pr, Fm;

    while (infile >> categray >> videos)
    {
        cin >> Re >> Pr >> Fm;
        cout << setw(28) << categray << setw(20) << videos << " ";
        cout << Re << " " << Pr << " " << Fm << endl;
    }

    infile.close();

    return 0;
}

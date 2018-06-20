#include <iostream>
#include <string>

using namespace std;

int main()
{
    string str;
    string value;

    while (cin >> str)
    {
        if (str == "-1")
        {
            cin >> value;
            cout << "\\textbf{" << value << "}" << " ";
        }
        else if (str == "\\\\")
        {
            cout << "\\\\" << endl;
        }
        else if (str == "\\hline")
        {
            cout << "\\hline" << endl;
        }
        else
        {
            cout << str << " ";
        }
    }
    return 0;
}

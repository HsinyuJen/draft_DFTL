#include <iostream>
#include <string>
#include <fstream>
#include <iomanip>

using namespace std;

static double data_MST[63];
static double data_RMoG[63];
static double data_MoG[63];
static double data_IMoG[63];
static double data_ViBe[63];
static double data_ViBep[63];
static double data_RECTGAUSS[63];
static double data_MultiLayer[63];
static double data_MultiCue[63];

void captureValue(string str,char* filename,double &re,double &pr,double &fm);

void fullData(char* filename,double data[63])
{
    ifstream infile("list.txt");
    string str;
    int count = 0;
    double re = 0;
    double pr = 0;
    double fm = 0;

    while (infile >> str)
    {
        re = -1;
        pr = -1;
        fm = -1;
        captureValue(str,filename,re,pr,fm);

       // cout << re << " " << pr << " "<< fm << endl;


        data[count] = re;
        data[count + 1] = pr;
        data[count + 2] = fm;

        count += 3;
    }
}

void captureValue(string str,char* filename,double &re,double &pr,double &fm)
{
    ifstream infile(filename);
    string input;

    while (infile >> input)
    {
        if (input == str)
        {
            infile >> re >> pr >> fm;
            break;
        }
    }

    infile.close();
}

void printfData(double data[63])
{
     ifstream infile("list.txt");
     string str = "";
     int i = 0;

     while (infile >> str)
     {
         cout << str << " " <<  data[i] << " " << data[i + 1] << " " << data[i + 2] << endl;
         i += 3;
     }

     infile.close();
}

float fixValue(double input)
{
     float value = input*100;
     value = (int)(value + 0.5);

     return value/100;
}

int main(int argc,char* argv[])
{
    fullData("result_MST.txt",data_MST);
    fullData("result_RMoG.txt",data_RMoG);
    fullData("result_MoG.txt",data_MoG);
    fullData("result_improveMoG.txt",data_IMoG);
    fullData("result_ViBe.txt",data_ViBe);
    fullData("result_ViBe+.txt",data_ViBep);
    fullData("result_045_full.txt",data_RECTGAUSS);
    fullData("result_1_025_full.txt",data_MultiLayer);
    fullData("result_SuBSENSE.txt",data_MultiCue);

    /*
    printfData(data_MST);
    cout << endl;
    cout << endl;

    printfData(data_RMoG);
    cout << endl;
*/
    string compare_MST = "MST";
    string compare_RMoG = "RMoG";
    string compare_MoG = "MoG";
    string compare_IMoG = "IMoG";
    string compare_ViBe = "ViBe";
    string compare_ViBep = "ViBe+";
    string compare_RECTGAUSS = "SPMS1";
    string compare_MultiLayer = "SPMS2";
    string compare_MultiCue = "SuBSEN";

    bool judge_MST = false;
    bool judge_RMoG = false;
    bool judge_MoG = false;
    bool judge_IMoG = false;
    bool judge_ViBe = false;
    bool judge_ViBep = false;
    bool judge_RECTGAUSS = false;
    bool judge_MultiLayer = false;
    bool judge_MultiCue = false;

    int count_MST = 0;
    int count_RMoG = 0;
    int count_MoG = 0;
    int count_IMoG = 0;
    int count_ViBe = 0;
    int count_ViBep = 0;
    int count_RECTGAUSS = 0;
    int count_MultiLayer = 0;
    int count_MultiCue = 0;

    string alg = "";
    const string end = "\\\\";

    while (cin >> alg)
    {

        if (alg == compare_MST)
        {
            judge_MST = true;
        }

        if (alg == compare_RMoG)
        {
             judge_RMoG = true;
        }

        if (alg == compare_MoG)
        {
            judge_MoG = true;
        }

        if (alg == compare_IMoG)
        {
             judge_IMoG = true;
        }

        if (alg == compare_ViBe)
        {
             judge_ViBe = true;
        }

        if (alg == compare_ViBep)
        {
            judge_ViBep = true;
        }

        if (alg == compare_RECTGAUSS)
        {
             judge_RECTGAUSS = true ;
        }

        if (alg == compare_MultiLayer)
        {
             judge_MultiLayer = true;
        }

        if (alg == compare_MultiCue)
        {
             judge_MultiCue = true;
        }


        if (alg == end)
        {
            if (judge_MST | judge_RMoG | judge_MoG | judge_IMoG | judge_ViBe | judge_ViBep | judge_RECTGAUSS | judge_MultiLayer | judge_MultiCue)
            {
                cout << end;
                cout << endl;
            }

            judge_MST = false;
            judge_RMoG = false;
            judge_MoG = false;
            judge_IMoG = false;
            judge_ViBe = false;
            judge_ViBep = false;
            judge_RECTGAUSS = false;
            judge_MultiLayer = false;
            judge_MultiCue = false;
        }

        if (judge_MST)
        {
            if (alg == "0.00")
            {

                printf("%.2f ",(float)fixValue(data_MST[count_MST]));
                count_MST ++;
            }
            else
            {
                cout << alg << " ";
            }
        }

        if (judge_RMoG)
        {
            if (alg == "0.00")
            {

                printf("%.2f ",(float)fixValue(data_RMoG[count_RMoG]));
                count_RMoG ++;
            }
            else
            {
                cout << alg << " ";
            }
        }


        if (judge_MoG)
        {
            if (alg == "0.00")
            {

                printf("%.2f ",(float)fixValue(data_MoG[count_MoG]));
                count_MoG ++;
            }
            else
            {
                cout << alg << " ";
            }
        }

        if (judge_IMoG)
        {
            if (alg == "0.00")
            {

                printf("%.2f ",(float)fixValue(data_IMoG[count_IMoG]));
                count_IMoG ++;
            }
            else
            {
                cout << alg << " ";
            }
        }


        if (judge_ViBe)
        {
            if (alg == "0.00")
            {

                printf("%.2f ",(float)fixValue(data_ViBe[count_ViBe]));
                count_ViBe ++;
            }
            else
            {
                cout << alg << " ";
            }
        }

        if (judge_ViBep)
        {
            if (alg == "0.00")
            {

                printf("%.2f ",(float)fixValue(data_ViBep[count_ViBep]));
                count_ViBep ++;
            }
            else
            {
                cout << alg << " ";
            }
        }

        if (judge_RECTGAUSS)
        {
            if (alg == "0.00")
            {

                printf("%.2f ",(float)fixValue(data_RECTGAUSS[count_RECTGAUSS]));
                count_RECTGAUSS ++;
            }
            else
            {
                cout << alg << " ";
            }
        }

        if (judge_MultiLayer)
        {
             if (alg == "0.00")
             {
                printf("%.2f ",(float)fixValue(data_MultiLayer[count_MultiLayer]));
                count_MultiLayer ++;
             }
             else
             {
                 cout << alg << " ";
             }
        }

        if (judge_MultiCue)
        {
             if (alg == "0.00")
             {
                printf("%.2f ",(float)fixValue(data_MultiCue[count_MultiCue]));
                 count_MultiCue ++;
             }
             else
             {
                 cout << alg << " ";
             }
        }
    }

    /*
    fullData(argv[1]);

 //   printfData();

    string alg = "";
    const string compare = "MST";
    const string end = "\\\\";
    bool judge = false;
    int count = 0;

    while (cin >> alg)
    {
        if (alg == compare)
        {
            judge = true;
        }

        if (alg == end)
        {
            if (judge)
            {
                cout << end;
                cout << endl;
            }

            judge = false;
        }

        if (judge)
        {
            if (alg == "0.00")
            {
//                cout << setprecision(2) << (double)fixValue(data[count]) << " ";

                printf("%.2f ",(float)fixValue(data[count]));
//                cout << fixValue(data[count]) << " ";
                count ++;
            }
            else
            {
                cout << alg << " ";
            }
        }

    }

    */
    return 0;
}

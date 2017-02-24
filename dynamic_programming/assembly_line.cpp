#include <iostream>
using namespace std;

typedef struct
{
    int n;      //装配线的装配站数量(the number of assembly station)
    int *e;     //进入装配站花费的时间(the time of entering assembly line i, i = 0, 1)
    int *x;     //离开装配站花费的时间(the time of leaving assemblu line i, i = 0, 1)
    int **a;    //在装配站上花费的时间(the time cost on assembly station)
    int **t;    //不同装配线间移动所花费时间(the transfering time of leaving assembly station to another assembly line)
}AssemblyLine;

void PrintStations(int **l, int line_of_end, int n);

void FastestWay(const AssemblyLine *line, int **&l, int **&f, int &ftotal, int &lend)
{
    int n = line->n;

    f[0][0] = line->e[0] + line->a[0][0];
    f[1][0] = line->e[1] + line->a[1][0];

    for (int j = 1; j < n; ++j)
    {
        // 如果 从 S0,j-1 到 S0,j 比从 S1,j-1 转过来花的时间少:
        // 1. 则最短时间是从 S0,j-1 至 S0,j;
        // 2. 反之，则从 S1,j-1 转过来更快;
        if (f[0][j - 1] + line->a[0][j] <= f[1][j - 1] + line->t[1][j - 1] + line->a[0][j])
        {
            f[0][j] = f[0][j - 1] + line->a[0][j];
            l[0][j] = 0;
        }
        else
        {
            f[0][j] = f[1][j - 1] + line->t[1][j - 1] + line->a[0][j];
            l[0][j] = 1;
        }

        // 如果 从 S1,j-1 到 S0,j 比从 S0,j-1 转过来花的时间少:
        // 1. 则最短时间是从 S1,j-1 至 S1,j;
        // 2. 反之，则从 S0,j-1 转过来更快;
        if (f[1][j - 1] + line->a[1][j] <= f[0][j - 1] + line->t[0][j - 1] + line->a[1][j])
        {
            f[1][j] = f[1][j - 1] + line->a[1][j];
            l[1][j] = 1;
        }
        else
        {
            f[1][j] = f[0][j - 1] + line->t[0][j - 1] + line->a[1][j];
            l[1][j] = 0;
        }
    }

    // 判断从 S0,n-1 出来更快，还是从 S1,n-1 出来 更快
    if (f[0][n - 1] + line->x[0] <= f[1][n - 1] + line->x[1])
    {
        ftotal = f[0][n - 1] + line->x[0];
        lend = 0;
    }
    else
    {
        ftotal = f[1][n - 1] + line->x[1];
        lend = 1;
    }

    cout << "最短耗时为:" << ftotal << endl;
    PrintStations(l, lend, n);
}

/*
 * 倒序输出装配站流程:
 * params:
 * **l:         记录装配线编号, li,j(j=1..n-1) 表示通过配送站 Si,j 的前一个装配线编号;
 * line_of_end: 从配送系统出来的线编号(0, 1);
 * n:           装配站总数;
 */
void PrintStations(int **l, int line_of_end, int n)
{
    int i = line_of_end + 1;

    cout << "第" << n << "站: 经过line " << i << ", station " << n << endl;
    for (int j = n - 1; j > 0; j--)
    {
        i = l[i][j];    // 经过 S(i,j) 之前一个点所在的装配线;
        cout << "第" << j << "站: 经过line " << i + 1 << ", station " << j << endl;
    }
}


int ASSEMBLY_LINE_NUM = 2;

int main(void)
{
    AssemblyLine line;

    line.n = 6;

    int a[2][6]={{7, 9, 3, 4, 8, 4},{8, 5, 6, 4, 5, 7}};
    line.a = new int *[ASSEMBLY_LINE_NUM];
    for (int i = 0; i < ASSEMBLY_LINE_NUM; ++i)
    {
        line.a[i] = new int [line.n];
        for(int j = 0; j < 6; j++ )
        {
          line.a[i][j] = a[i][j];
        }
    }

    int t[2][6]={{2, 3, 1, 3, 4}, {2, 1, 2, 2, 1}};
    line.t = new int *[2];
    for (int i = 0; i < 2; ++i)
    {
        line.t[i] = new int [line.n - 1];
        for(int j = 0; j < 6-1; j++ )
        {
            line.t[i][j] = t[i][j];
        }
    }

    // 进入装配站耗时
    line.e = new int [2];
    line.e[0] = 2;
    line.e[1] = 4;

    // 出装配站耗时
    line.x = new int [2];
    line.x[0] = 3;
    line.x[1] = 2;

    int **l = new int *[2];       // 记录通过 Si,j 的上一个点是经过的装配线编号;
    int **f = new int *[2];       // 记录最优路线花费时间;
    for (int i = 0; i < 2; ++i)
    {
        l[i] = new int [line.n];
        f[i] = new int [line.n];
    }

    int lend, ftotal;

    FastestWay(&line, l, f, ftotal, lend);

    return 0;
}

import os 
import math

def put_figure_to_tex(content,f_name,cols,ratio):
    files = os.listdir(content)
    f = open(f_name,"w+",encoding='utf-8')

    num = len(files);
    m = int(math.ceil(num / cols));

    k = 0
    for i in range(m):
        f.write("\\begin{figure}[!htbp]\n\\centering\n");
        for j in range(cols):
            if k == num:
                break
            file = files[k]
            k = k + 1
            f.write("\\begin{minipage}{%.1f\\linewidth}\n\\centering\n"% ratio)
            f.write("\\includegraphics[width=.9\\textwidth]{%s}\n" % file)
            f.write("\\end{minipage}\n")
        f.write("\\end{figure}\n");
        if k == num:
            break
    f.close()


for i in range(4):
    content = "result/figuresA/figure_A"+str(i+1)+'/'
    f_name = "Report/dataA"+str(i+1)+"_image.txt"
    ratio = 0.1  # 每列宽
    cols = 5 # 列数
    put_figure_to_tex(content,f_name,cols,ratio)

for i in range(5):
    content = "result/figuresB/figure_B"+str(i+1)+'/'
    f_name = "Report/dataB"+str(i+1)+"_image.txt"
    ratio = 0.1  # 每列宽
    cols = 5 # 列数
    put_figure_to_tex(content,f_name,cols,ratio)
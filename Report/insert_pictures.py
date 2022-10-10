import os 
import math

def put_figure_to_tex(content,f_name,cols,ratio):
    f = open(f_name,"w+",encoding='utf-8')
    dirs = os.listdir(content)
    for l in range(len(dirs)):
        path = content + dirs[l] + '/'
        files = os.listdir(path)
        name = dirs[l].split('_')[1]


        num = len(files);
        m = int(math.ceil(num / cols));

        f.write("\\newpage\n")
        f.write("\\section{问题一data"+name+"排样方案}\n")
        k = 0
        for i in range(m):
            f.write("\\begin{figure}[!htbp]\n\\centering\n");
            for j in range(cols):
                if k == num:
                    break
                file = files[k]
                k = k + 1
                f.write("\\begin{minipage}{%.1f\\linewidth}\n\\centering\n"% ratio)
                f.write("\\includegraphics[width=.9\\textwidth]{../%s%s}\n" % (path,file))
                # f.write("\\caption{%s}\n" % (file.split('.')[0]))
                f.write("\\end{minipage}\n")
            f.write("\\end{figure}\n");
            if k == num:
                break
    f.close()


content = "result2/figuresA/"
f_name = "Report/dataA_image.txt"
ratio = 0.09  # 每列宽
cols = 9 # 列数
put_figure_to_tex(content,f_name,cols,ratio)

# content = "result2/figuresB/"
# f_name = "Report/dataB_image.txt"
# ratio = 0.09  # 每列宽
# cols = 9 # 列数
# put_figure_to_tex(content,f_name,cols,ratio)
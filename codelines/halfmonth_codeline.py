import csv
import matplotlib.pyplot as plt
import numpy as np
import matplotlib
from collections import Counter
import operator

def main():
    plt.rcdefaults()
    fig, ax = plt.subplots()
    csv_file =  open('half_month_code.csv')
    csv_reader_lines =  csv.reader(csv_file)
    data = []
    total_data = []
    list = []
    count = 0
    for  i in csv_reader_lines:
        data.append(i)
        total_data={'name':data[count][0],'addcode':data[count][1],'codedel':data[count][2]}
        count=count+1
        list.append(total_data)
    l1 = sorted(list,key=lambda x:(int(x['addcode'])))
    add_dir = {}
    del_dir = {}
    for j in l1:
        if j['name'] not in add_dir:
            add_dir[j['name']]=int(j['addcode'])
        else:
            add_dir[j['name']] += int(j['addcode'])
    for j in l1:
        if j['name'] not in del_dir:
            del_dir[j['name']]=int(j['codedel'])
        else:
            del_dir[j['name']] += int(j['codedel'])
    new_add = []
    for k,v in add_dir.items():
        new_add.append({'name':k,'addcode':v})
    l2 = sorted(new_add, key=lambda x: (int(x['addcode'])))
    new_del= []
    for k, v in del_dir.items():
        new_del.append({'name': k, 'codedel': v})
    l3 = new_del
    new_list = {}
    l5= []
    for i in l2 :
        for j in l3:
            if (i['name'] == j['name']):
                new_list = {'name':i['name'],'addcode':i['addcode'],'codedel':j['codedel']}
                l5.append(new_list)
    name = []
    code_add = []
    code_del = []
    for i in l5:
        name.append(i['name'])
        code_add.append(i['addcode'])
        code_del.append(i['codedel'])
    y_pos = np.arange(len(name))
    total_width,n = 0.8,2
    width = total_width / n
    y_pos = y_pos - (total_width - width)/2
    b = ax.barh(y_pos,code_add,align='center',height=0.2,label='addcode')
    for rect in b:
        w = rect.get_width()
        ax.text(w,rect.get_y()+rect.get_height()/2,'%d'%int(w))
    b = ax.barh(y_pos+width,code_del,align='center',height=0.2,label='delcode')
    for rect in b:
        w = rect.get_width()
        ax.text(w,rect.get_y()+rect.get_height()/2,'%d'%int(w))
    ax.set_yticks(y_pos+width/2)
    ax.set_yticklabels(name)
    plt.title('Nearly 15 days of code statistics')
    plt.legend(loc='lower right')
    fig = matplotlib.pyplot.gcf()
    fig.set_size_inches(40, 20)
    fig.savefig('/var/www/html/pic/789.png', dpi=300, bbox_inches='tight')
   # plt.show()

if __name__ == '__main__':
    main()



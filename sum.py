import sys
import argparse

# 创建一个解析器对象
parser = argparse.ArgumentParser()

# 添加需要解析的参数
parser.add_argument('num_clients', type=int, help='number of clients')

# 解析命令行参数
args = parser.parse_args()

# 获取解析后的参数值
num_clients = args.num_clients

# 根据参数值选择对应的输入文件内容
if num_clients == 1:
    file_names = ['out192.168.1.52.txt']
elif num_clients == 2:
    file_names = ['out192.168.1.52.txt', 'out192.168.1.53.txt']
elif num_clients == 4:
    file_names = ['out192.168.1.51.txt', 'out192.168.1.52.txt', 'out192.168.1.53.txt', 'out192.168.1.33.txt']
elif num_clients == 8:
    file_names = ['out192.168.1.51.txt', 'out192.168.1.52.txt', 'out192.168.1.53.txt', 'out192.168.1.33.txt', 'out192.168.1.44.txt', 'out192.168.1.69.txt', 'out192.168.1.88.txt', 'out192.168.1.89.txt']
print(file_names)

# 定义累加变量
merge_cnt_total = 0
merge_time_total = 0
split_cnt_total = 0
split_time_total = 0
insert_time_total = 0

# 遍历文件列表
for idx, file_name in enumerate(file_names):
    with open(file_name, 'r') as file:
        # 读取文件内容
        lines = file.readlines()

        # 遍历每一行
        for line in lines:
            # 判断是否包含merge_cnt等数据
            if 'merge_cnt' in line:
                # 解析数据
                data = line.strip().split(', ')
                merge_cnt = int(data[0].split(':')[1])
                merge_time = float(data[1].split(':')[1])
                split_cnt = int(data[2].split(':')[1])
                split_time = float(data[3].split(':')[1])
                insert_time = float(data[4].split(':')[1])

                # 累加
                merge_cnt_total += merge_cnt
                merge_time_total += merge_time
                split_cnt_total += split_cnt
                split_time_total += split_time
                insert_time_total += insert_time
# 输出总体统计结果
output_total = f"\nTotal: merge_cnt:{merge_cnt_total}, merge_time:{merge_time_total}, split_cnt:{split_cnt_total}, split_time:{split_time_total}, insert_time:{insert_time_total}"
print(output_total)


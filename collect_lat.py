import argparse
import math

# 创建命令行参数解析器
parser = argparse.ArgumentParser(description='计算操作延迟统计信息')
parser.add_argument('operation', choices=['insert', 'search'], help='操作参数：insert 或 search')
parser.add_argument('server_count', type=int, help='服务器数量')
parser.add_argument('cli_num', type=int, help='client数量')
parser.add_argument('coro_num', type=int, help='coro数量')
args = parser.parse_args()

operation = args.operation
server_count = args.server_count
cli_num = args.cli_num
coro_num = args.coro_num

filename_prefix = f"{operation}_lat"
all_filenames = []  # 新增空列表用于存储所有的 filenames
if(server_count==1):
    sequence = [2 ** i for i in range(int(math.log2(cli_num)) + 1)]
    for cli_id in sequence:
        for coro_id in range(1,coro_num+1):
            filenames = [f"{filename_prefix}_{server_count}_{cli_id}_{coro_id}.txt"]
            all_filenames.extend(filenames)  # 将生成的 filenames 追加到 all_filenames
else:
    cli_id = 16
    sequence = [2 ** i for i in range(1,int(math.log2(server_count)) + 1)]
    for server_id in sequence:
        for coro_id in range(1,coro_num+1):
            filenames = [f"{filename_prefix}_{server_id}_{cli_id}_{coro_id}.txt"]
            all_filenames.extend(filenames)  # 将生成的 filenames 追加到 all_filenames

print(len(all_filenames))
print(all_filenames)

# 打开输出文件
with open("merged_file.txt", "w") as output_file:
    # 遍历每个文件
    for file_name in all_filenames:
        # 写入文件名
        output_file.write(f"文件名：{file_name}\n")
        
        # 打开当前文件
        with open(file_name, "r") as input_file:
            # 将当前文件内容写入输出文件
            output_file.write(input_file.read())
        
        # 写入一个空行作为分隔符
        output_file.write("\n")

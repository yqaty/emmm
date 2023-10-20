# /bin/bash
# usage: 
#       server: sudo ../ser_cli.sh server
#       client_0: sudo ../ser_cli.sh 0
#       client_1: sudo ../ser_cli.sh 1
#       为了兼容cal_lat, client端接收$2 $3用来指定num_cli,num_coro
#       num_cli : 0~4
#       num_coro : 1~4
if [ "$1" = "server" ]
then
    echo "server"
    ./ser_cli_var_kv --server \
    --roce \
    --max_coro 256 --cq_size 64 \
    --mem_size 91268055040
    # --mem_size 85899345920 
    # --mem_size 53687091200
    # --mem_size 64424509440 
    # --mem_size 107374182400 
    # --mem_size 96636764160
    # --mem_size 26843545600 
else
    echo "machine" $1

    for read_size in `seq 6 6`;do
        echo "read_size" $((1<<$read_size))
        for num_cli in `seq $2 $2`;do
            for num_coro in `seq 1 $3`;do
        # for num_cli in 1 2 4 8 16;do
        #     for num_coro in 1 2 3 4;do
                # for ((load_num=10000000;load_num<=100000000;load_num+=10000000)); do
                # for ((load_num=10000;load_num<=266000;load_num+=1000)); do
                # for load_num in 1000 10000 100000 1000000 10000000 ;do
                # 426847 12736
                for load_num in 10000000;do
                    echo "num_cli" $num_cli "num_coro" $num_coro "load_num" $load_num
                    ./ser_cli_var_kv \
                    --server_ip 192.168.1.52 --num_machine $4 --num_cli $num_cli --num_coro $num_coro \
                    --roce \
                    --max_coro 256 --cq_size 64 \
                    --machine_id $1  \
                    --load_num $load_num \
                    --num_op 1000000 \
                    --pattern_type 0 \
                    --insert_frac 0.0 \
                    --read_frac   1.0 \
                    --update_frac  0.0 \
                    --delete_frac  0.0 \
                    --read_size     $((1<<$read_size))
                done 
            done
        done
    done
fi
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:10 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404013
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:103 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404027
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:59 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404098
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:87 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404171
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:125 at first level
# ERROR [/mxhhome/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404250
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:85 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404366
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:34 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404389
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:8 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404507
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:61 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404723
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:121 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404782
# ERROR [/home/mxh/SepHash-M/src/plush.cc:234] insert: [0:0]migrate_top group:16 at first level
# ERROR [/home/mxh/SepHash-M/./include/plush.h:91] print: line:235 key:404817


# YCSB A : read:0.5,insert:0.5 zipfian(2)
# YCSB B : read:0.95,update:0.05 zipfian(2)
# YCSB C : read:1.0,update:0.0 zipfian(2)
# YCSB D : read:0.95,insert:0.5 latest(3)
# YCSB E : scan--不考虑
# YCSB F : read:0.5,rmq:0.5 zipfian(2) -- RMW ，不考虑

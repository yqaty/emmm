# /bin/bash
clis=("192.168.1.52" "192.168.1.53" "192.168.1.51" "192.168.1.33" "192.168.1.44"  "192.168.1.69" "192.168.1.88" "192.168.1.89" )
../sync.sh out 8
echo "start" > sum.txt
for num_machine in 1;do
  for num_cli in `seq 0 4`;do
    for num_coro in `seq 1 4`;do
    python3 ../run.py $num_machine client $((1<<$num_cli)) $num_coro
    ../sync.sh in $num_machine $((1<<$num_cli)) $num_coro
    cli=${clis[0]}
    echo "num_machine=$num_machine,num_cli=$((1<<$num_cli)),num_coro=$num_coro" >> sum.txt
    python3 ../sum.py $num_machine >> sum.txt
    # 额外统计retry_cnt/level_cnt等，可以直接复用cal_lay.py的代码
    python3 ../cal_lat.py insert $num_machine $((1<<$num_cli)) $num_coro 1>insert_lat_${num_machine}_$((1<<$num_cli))_$num_coro.txt
    python3 ../cal_lat.py search $num_machine $((1<<$num_cli)) $num_coro 1>search_lat_${num_machine}_$((1<<$num_cli))_$num_coro.txt
    rm -f insert_lat*192.168.*.txt
    rm -f search_lat*192.168.*.txt
    done 
  done 
done
for num_machine in 2 4 8;do
  for num_cli in `seq 4 4`;do
    for num_coro in `seq 1 4`;do
    python3 ../run.py $num_machine client $((1<<$num_cli)) $num_coro
    ../sync.sh in $num_machine $((1<<$num_cli)) $num_coro
    echo "num_machine=$num_machine,num_cli=$((1<<$num_cli)),num_coro=$num_coro" >> sum.txt
    python3 ../sum.py $num_machine >> sum.txt
    # 额外统计retry_cnt/level_cnt等，可以直接复用cal_lay.py的代码
    python3 ../cal_lat.py insert $num_machine $((1<<$num_cli)) $num_coro 1>insert_lat_${num_machine}_$((1<<$num_cli))_$num_coro.txt
    python3 ../cal_lat.py search $num_machine $((1<<$num_cli)) $num_coro 1>search_lat_${num_machine}_$((1<<$num_cli))_$num_coro.txt
    rm -f insert_lat*192.168.*.txt
    rm -f search_lat*192.168.*.txt
    done 
  done
done
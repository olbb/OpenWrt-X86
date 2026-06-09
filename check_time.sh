echo "[模式 B] 编译成功，正在通过 [.prepared -> .built] 时间差逆向计算纯耗时 (前 100 名):"
echo "------------------------------------------------------------------------------"

# 扫描所有已编译完成的组件隐式标记
find build_dir/target-x86_64_musl/ -name ".built_*" 2>/dev/null | while read built_file; do
  # 寻找同目录下对应的准备就绪标记
  dir_path=$(dirname "$built_file")
  prepared_file=$(find "$dir_path" -name ".prepared_*" | head -n 1)
  
  if [ -f "$prepared_file" ]; then
    # 获取两个文件的 Unix 时间戳（秒）
    start_time=$(stat -c %Y "$prepared_file")
    end_time=$(stat -c %Y "$built_file")
    # 计算差值
    duration=$((end_time - start_time))
    
    # 提取好看的组件文件夹名称
    pkg_name=$(basename "$dir_path")
    
    # 过滤掉 0 秒或负数的异常数据，格式化输出
    if [ $duration -gt 0 ]; then
      printf "%-60s | 纯耗时: %d 秒\n" "$pkg_name" "$duration"
    fi
  fi
done | sort -t: -k2 -nr | head -n 100

echo "------------------------------------------------------------------------------"

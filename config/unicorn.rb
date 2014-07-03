@dir = File.expand_path('../../', __FILE__)

worker_processes 2 # CPUのコア数に揃える
working_directory @dir

timeout 300
if ENV['RACK_ENV'] == 'development'
  listen 8080
else
  listen '/var/tmp/unicorn.sock'
end

pid "#{@dir}/tmp/pids/unicorn.pid" #pidを保存するファイル

# unicornは標準出力には何も吐かないのでログ出力を忘れずに
stderr_path "#{@dir}/log/unicorn.stderr.log"
stdout_path "#{@dir}/log/unicorn.stdout.log"

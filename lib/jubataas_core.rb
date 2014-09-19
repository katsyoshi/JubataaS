module JubataasCore
  def update(source)
    jubatus_status_update(source) do |src|
      client_update(src)
    end
  end

  def analyze(source)
    jubatus_status_update(source) do |src|
      client_analyze(src)
    end
  end

  def clear
    @jubatus.clear
  end

  def load(path)
    @jubatus.load(path)
  end

  def save(path)
    @jubatus.save(path)
  end

  def status
    @jubatus.get_status.first[1]
  end

  private

  def client_update(source)
  end

  def client_analyze(source)
  end

  def jubatus_status_update(source, &block)
    retry_num = 0
    src = convert2jubatus(source)
    begin
      yield(src)
    rescue MessagePack::RPC::TimeoutError
      if retry_num < 5
        retry_num += 1
        sleep 0.5
        retry
      end
    end
  end

  # convert data for jubatus
  # @param [Hash] source { types: {key0: type, key1: type}, data: [{key0: val},{key1: val}], label: {data0: label, data1: label} }
  # @return [Jubatus::Common::Datum] data_list input data for jubatus
  def convert2jubatus(source)
    types = source['types']
    data = source['data']
    label = source['label'] ? source['label'] : nil
    data_list = []
    data.each_with_index do |datum, i|
      d = {}
      datum.each do |key, val|
        d[key] = case types[key].to_s
          when /num/i then val.to_f
          when /str/i then val.to_s
          when /bin/i then Base64.decode64(val)
        end
      end
      jd = Jubatus::Common::Datum.new(d)
      data_list << (label.nil? ? jd : [label[i.to_s].to_s, jd])
    end
    data_list
  end
end

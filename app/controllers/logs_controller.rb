class LogsController < ApplicationController
  before_action :set_all_logs
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  # GET /logs
  # GET /logs.json
  def index
    @log = Rails.env
    @log_file = get_log_file
  end

  # GET /logs/1
  # GET /logs/1.json
  def show
  end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs
  # POST /logs.json
  def create
    @log = Log.new(log_params)

    respond_to do |format|
      if @log.save
        format.html { redirect_to @log, notice: 'Log was successfully created.' }
        format.json { render :show, status: :created, location: @log }
      else
        format.html { render :new }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logs/1
  # PATCH/PUT /logs/1.json
  def update
    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to @log, notice: 'Log was successfully updated.' }
        format.json { render :show, status: :ok, location: @log }
      else
        format.html { render :edit }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to logs_url, notice: 'Log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_all_logs
      @logs = Dir.entries('log')
      
      @logs.delete_if { |l| l.starts_with? '.' }
      @logs.delete_if { |l| not l.ends_with? 'log' }
      
      @logs.map! { |l| File.basename(l, File.extname(l)) }
      @logs.delete_if { |l| is_wrong_environment? l }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = params[:id]
      @log_file = get_log_file
    end

    def get_log_file
      tail "./log/#{@log}.log", 200
    end

    def is_wrong_environment? environment
      environment_list = Dir.glob "./config/environments/*.rb"
      environment_list.map! { |e| File.basename(e, ".rb") }

      return false unless environment_list.include? environment
      environment != Rails.env
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.fetch(:log, {})
    end

    def tail(path, n)
      file = File.open(path, "r")
      buffer_s = 512
      line_count = 0
      file.seek(0, IO::SEEK_END)

      offset = file.pos # we start at the end

      while line_count <= n && offset > 0
        to_read = if (offset - buffer_s) < 0
                    offset
                  else
                    buffer_s
                  end

        file.seek(offset-to_read)
        data = file.read(to_read)

        data.reverse.each_char do |c|
          if line_count > n
            offset += 1
            break
          end
          offset -= 1
          if c == "\n"
            line_count += 1
          end
        end
      end

      file.seek(offset)
      data = file.readlines

      data.map! { |line|
        next line unless line.include? "\e"
        line.gsub! "\e", "]"
        line.sub! "]", "\e"
        
        line.reverse!
        line.sub! "\n", "]"
        line.reverse!
      }

      file.close
      data
    end

end

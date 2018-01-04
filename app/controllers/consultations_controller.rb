class ConsultationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_consultation, only: [:edit, :update, :destroy, :show, :enterroom, :dataupload]

  #_uploaddata_formからのupdateのため
  protect_from_forgery :except => ["update","dataupload"]

  def index
    #@consultations = Consultation.page(params[:page]).per(10).order('id DESC')
    @consultations = current_user.consultations.joins(:event).where('(events.planed_start >= ?) AND (events.planed_start < ?)',Date.today,Date.today+1).order('planed_start DESC')
    @consultations_past = current_user.consultations.joins(:event).where('events.planed_start < ?',Date.today).page(params[:page]).per(10).order('planed_start DESC')
    @consultations_future = current_user.consultations.joins(:event).where('events.planed_start >= ?',Date.today+1).order('planed_start DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @comment = @consultation.comments.build
    @comments = @consultation.comments.order('id DESC')
    @report = @consultation.reports.build
    @reports = @consultation.reports
  end

  def new
    if params[:back]
      @user = User.find(params[:user_id]).becomes(User)
      @event = Event.new(events_params)
      @consultation = @event.consultations.build(consultations_params)
    else
      @user = User.find(params[:user_id]).becomes(User)
      @event = @user.events.build
      @consultation = @event.consultations.build
    end
  end

  def create
    @event = Event.new(events_params)

    #終了予定日時は開始予定日時+15分とする

    if events_params[:planed_start]!=""
      @event.planed_end = events_params[:planed_start].to_datetime + Rational(15, 24 * 60)
      #events_params[:planed_end] = (events_params[:planed_start].to_datetime + Rational(15, 24 * 60)).strftime('%Y/%m/%d %H:%M')
    end

    @consultation = @event.consultations.build(consultations_params)
    if @event.save && @consultation.save
      redirect_to consultations_path, notice: "相談を依頼しました！"
      #NoticeMailer.sendmail_consultation(@consultation).deliver
    else
      redirect_to :back, :notice => 'message'
    end
  end

  def edit
    if @consultation.user_id != current_user.id then
      redirect_to consultations_path, notice: "相談の投稿者しか編集できません"
    end
  end

  def update
    respond_to do |format|
      @consultation.update(consultations_params)
      format.html { redirect_to consultation_path(@consultation), notice: '相談を更新しました。' }
      format.js
    end
  end

  def destroy
    if @consultation.client_id != current_user.id then
      redirect_to consultations_path, notice: "相談者しか削除できません"
    end

    @consultation.destroy
    redirect_to consultations_path, notice: "相談を削除しました！"
  end

  def confirm
    @event = Event.new(events_params)
    @consultation = @event.consultations.build(consultations_params)
    @user = User.find(@consultation.consultant_id).becomes(User)

    render :new if @consultation.invalid? || @event.invalid?

  end

  def enterroom
    respond_to do |format|
      @consultation.update(consultations_params)
      Pusher.trigger('test_channel', 'enter_room', {
        message: User.find(consultations_params[:consultant_id]).name+'さんが入室しました', consultaton_id: consultations_params[:id]
      })
      #json message =  "message": "<consultant>さんが入室しました", "consultaton_id": "<consultations_params[:id]>, "roomnumber": "<roomnumber>"
      format.html {render :nothing => true}
      format.js{render :nothing => true}
    end
  end

  def dataupload
    @consultation.image_data(params[:url])
    respond_to do |format|
      @consultation.update(consultations_params)
      format.html {render :nothing => true}
      format.js{render :nothing => true}
    end
  end

  private
    def consultations_params
      #params.require(:consultation).permit(:event_id, :memo, :client_id, :consultant_id, :data, :data_cache, :remove_data,:id)
      params.require(:consultation).permit(:event_id, :memo, :data, :data_cache, :remove_data,:id, :consultant_id, :client_id, :roomnumber)
    end

    def events_params
      #params.require(:event).permit(:title,:user_id, :id, consultation: [:id, :memo, :client_id, :consultant_id, :data, :data_cache, :remove_data])
      params.require(:event).permit(:title,:user_id, :id, :planed_start, :planed_end, :actual_start, :actual_end)
    end

    def set_consultation
      #@consultation = Consultation.find(params[:id])
      @consultation = Consultation.find_by(:id => params[:id])
      if @consultation.nil?
        redirect_to consultations_path, notice: "相談が存在しません"
      end
    end
end

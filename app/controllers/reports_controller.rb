class ReportsController < ApplicationController

  def create
    @report = current_user.reports.build(report_params)
    @consultation = @report.consultation

    respond_to do |format|
      if @report.save
        format.html { redirect_to consultation_path(@consultation) }
        format.js { render :index }
      else
        format.html { render :new }
        format.js { render :index }
      end
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @consultation = @report.consultation
    respond_to do |format|
      @report.destroy
      format.html { redirect_to consultation_path(@consultation), notice: 'レポートを削除しました。' }
      format.js { render :index }
    end
  end

  def edit
    @report = Report.find(params[:id])
    @consultation = @report.consultation
  end

  def update
    @report = Report.find(params[:id])
    @consultation = @report.consultation
    @reports = @consultation.reports.order('id DESC')
    respond_to do |format|
      @report.update(report_params)
      format.html { redirect_to consultation_path(@consultation), notice: 'レポートを更新しました。' }
      format.js { render :index }
    end
  end

  def cancel
    @report = Report.find(params[:id])
    @consultation = @report.consultation
    respond_to do |format|
      format.js { render :index }
    end
  end

  def report_params
    params.require(:report).permit(:consultation_id, :content, :disclose, :id)
  end
end

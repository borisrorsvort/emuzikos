class TestimonialsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    @testimonials = Testimonial.approved.order("created_at DESC").page.per(20)
  end

  def new
    @testimonial = Testimonial.new
  end

  def create
    @testimonial = Testimonial.new(params[:testimonial])
    @testimonial.user = @current_user

    if @testimonial.save
      gflash :success => true
      redirect_to testimonials_url
    else
      render :new
    end
  end

end

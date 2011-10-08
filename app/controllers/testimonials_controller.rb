class TestimonialsController < ApplicationController
  def index
    @testimonials = Testimonial.approved.order("created_at DESC").page.per(20)
  end
  
  def show
    @testimonial = Testimonial.approved.find(params[:id])
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
      render :action => 'new'
    end
  end
  
  def edit
    @testimonial = Testimonial.find(params[:id])
  end
  
  def update
    @testimonial = Testimonial.find(params[:id])
    if @testimonial.update_attributes(params[:testimonial])
      gflash :success => true
      redirect_to @testimonial
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    gflash :success => true
    redirect_to testimonials_url
  end
end

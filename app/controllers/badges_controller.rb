class BadgesController < ApplicationController

  require 'fpdf'

  def pdf
    send_data gen_pdf, :filename => "something.pdf", :type => "application/pdf"
  end

  private
  def gen_pdf
    
    # card dimensions
    image_x = 10
    image_y = 35
    image_w = 35
    image_h = 40
    card_w = 80
    card_h = 50

    @person = Person.find(params[:id])
  
    pdf = FPDF.new
    pdf.AddPage
    pdf.SetFont('Arial','B',16)

    # front of card
    pdf.SetFontSize(12)
    pdf.SetTextColor(155,155,155)
    pdf.Text(5,29,'FRONT')
    pdf.SetTextColor(0,0,0)
    pdf.Rect(5,30,card_w,card_h)
    
    # put image here...
    #pdf.Image(file,x,y,w,h,'jpg')
    pdf.Rect(image_x,image_y,image_w,image_h)

    # card field titles
    pdf.SetFontSize(4)
    pdf.Text(50,35,'NAME')
    pdf.Text(50,50,'ID NUMBER')
    pdf.Text(50,60,'FACILITY')
    pdf.Text(50,70,'SIGNATURE')

    # person data
    pdf.SetFontSize(12)
    pdf.Text(50,40,@person.first_name.capitalize)
    pdf.Text(50,45,@person.last_name.capitalize)
    pdf.Text(50,55,@person.tag_id)
    pdf.SetTextColor(255,0,0)
    #pdf.Text(50,65,@person.shelter.name.upcase)
    pdf.Text(50,65,'WINDSOR')


    # back of card
    indention = 10
    start_position = 100
    pdf.SetFontSize(12)
    pdf.SetTextColor(155,155,155)
    pdf.Text(indention - 5,start_position - 1,'BACK')
    pdf.SetTextColor(0,0,0)
    pdf.Rect(indention - 5,start_position,card_w,card_h)
    pdf.SetFontSize(12)
    pdf.SetFontSize(8)
    pdf.Text(indention,start_position += 5,'ASSOCIATED FAMILY MEMBERS AT SAME FACILITY')
    pdf.SetFontSize(4)
    pdf.Text(indention,start_position += 5,'NAME / ID NUMBER')
    pdf.SetFontSize(8)
    @person.family.people.each do |member|
      pdf.Text(indention,start_position += 5,"#{member.first_name.capitalize} #{member.last_name.capitalize} / #{member.tag_id}")
    end
    
    # generate the doc
    pdf.Output
  end
end

class BadgesController < ApplicationController

  require 'fpdf'

  def pdf
    #send_data gen_pdf_print, :filename => "something.pdf", :type => "application/pdf"
    send_data gen_pdf_badge, :filename => "something.pdf", :type => "application/pdf"
  end

  private
  def gen_pdf_badge

    # dimensions and params
    margin = 0.5
    huge_font = 16
    large_font = 12
    medium_font = 8
    small_font = 6
    tiny_font = 4
    image_x = margin + 0.1
    image_y = margin + 0.65
    #image_w = 1.25
    #image_h = 1.5
    aspect_ratio = 352 / 288.0
    image_h = 1.25
    image_w = image_h * aspect_ratio
    card_w = 3.5 + 0.1
    card_h = 2.25 + 0.1

    @person = Person.find(params[:id])
  
    pdf = FPDF.new('P','in')
    pdf.SetTopMargin(margin)
    pdf.SetLeftMargin(margin)
    pdf.SetRightMargin(margin)
    pdf.AddPage
    pdf.SetFont('Arial','B',16)

    # front of card
    #pdf.SetFillColor(220,220,220) # light grey
    #pdf.Rect(margin,margin,card_w,card_h,'DF')
    pdf.Image('./public/images/card_front_300dpi.jpg',margin,margin,card_w,card_h)
    pdf.SetFontSize(huge_font)
    pdf.SetTextColor(0,0,0) # black
    pdf.Text(margin + 0.2,margin + 0.35,'San Antonio, Texas')
    pdf.SetTextColor(0,0,0) # black
    pdf.SetFontSize(large_font)
    #pdf.SetFillColor(255,255,255) # white
    
    # put image here...
    #pdf.Image('/tmp/test.jpg',image_x,image_y,image_w,image_h)
    pdf.Rect(image_x,image_y,image_w,image_h,'DF')

    # card field titles
    pdf.SetFontSize(tiny_font)
    pdf.Text(image_x + image_w + 0.1,image_y + 0.1,'NAME')
    pdf.Text(image_x + image_w + 0.1,image_y + 0.6,'ID NUMBER')
    pdf.Text(image_x + image_w + 0.1,image_y + 0.9,'FACILITY')
    #pdf.Text(image_x + image_w + 0.2,image_y + 1.2,'SIGNATURE')
    pdf.SetDrawColor(155,155,155) # light grey
    pdf.SetLineWidth(0.00001)
    pdf.Line(margin + 0.2,margin + card_h - 0.1,margin + card_w - 0.2, margin + card_h - 0.1)
    pdf.Text(image_x + image_w + 0.1,image_y + 1.2,'SIGNATURE')
    pdf.SetFontSize(huge_font)
    pdf.SetFont('Arial')
    pdf.Text(margin + 0.2,margin + card_h - 0.15,'X')
    pdf.SetFont('Arial','B',16)

    # person data
    pdf.SetFontSize(large_font)
    pdf.Text(image_x + image_w + 0.1,image_y + 0.3,@person.first_name.capitalize)
    pdf.Text(image_x + image_w + 0.1,image_y + 0.5,@person.last_name.capitalize)
    pdf.Text(image_x + image_w + 0.1,image_y + 0.8,@person.tag_id)
    pdf.SetTextColor(255,0,0) # red
    pdf.Text(image_x + image_w + 0.1,image_y + 1.1,@person.shelter.name.upcase)
    #pdf.Text(image_x + image_w + 0.1,image_y + 1.1,'WINDSOR')


    # back of card
    people = @person.family.people
    #pdf.SetFillColor(220,220,220) # light grey
    #pdf.Rect(margin+card_w,margin,card_w,card_h,'DF')
    pdf.Image('./public/images/card_back_300dpi.jpg',margin+card_w + 0.1,margin,card_w,card_h)
    pdf.SetFontSize(medium_font)
    pdf.SetTextColor(0,0,0) # black
    pdf.Text(margin + card_w + 0.4, margin + 0.3,'ASSOCIATED FAMILY MEMBERS AT SAME FACILITY')
    pdf.SetFontSize(tiny_font)
    pdf.Text(margin + card_w + 0.3, margin + 0.5,'NAME / ID NUMBER')
    start_position = margin + 0.5
    indention = margin + card_w + 0.3
    case people.nitems 
      when 0..8: 
        spacing = 0.2
	font_size = medium_font
      when 9..16:
        spacing = 0.1
	font_size = medium_font
      when 17..30:
        spacing = 0.1
	font_size = small_font
      else
        spacing = 0.1
	font_size = tiny_font
    end
    pdf.SetFontSize(font_size)
    people.each do |member|
      if start_position + spacing > 2.8
        (people.nitems > 30) ? indention += 1 : indention += 1.5
	start_position = margin + 0.5
        pdf.SetFontSize(tiny_font)
        pdf.Text(indention, margin + 0.5,'NAME / ID NUMBER')
        pdf.SetFontSize(font_size)
      end
      pdf.Text(indention,start_position += spacing,"#{member.first_name.capitalize} #{member.last_name.capitalize} / #{member.tag_id}")
    end
    
    # generate the doc
    pdf.Output
  end

end

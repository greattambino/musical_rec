# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  link       :string(255)
#  uid        :string(255)
#  author     :string(255)
#  duration   :string(255)
#  likes      :string
#  dislikes   :string
#  views      :string

class Video < ActiveRecord::Base

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*\z/i
  validates :link, presence: true, format: YT_LINK_FORMAT

  before_create -> do
    uid = link.match(YT_LINK_FORMAT)

    self.uid = uid[2] if uid && uid[2]

    if self.uid.to_s.length != 11
      self.errors.add(:link, 'is invalid.')
      false
    elsif Video.where(uid: self.uid).any?
      self.errors.add(:link, 'is not unique.')
      false
    else
      get_additional_info
    end
  end


private
 
  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
      video  = client.video_by(uid)
      self.title    = video.title
      self.duration = parse_duration(video.duration)
      self.author   = video.author.name
      self.likes    = parse_count(video.rating.likes)
      self.dislikes = parse_count(video.rating.dislikes)
      self.views    = parse_count(video.view_count)
    rescue
      self.title = '' ; self.duration = '00:00' ; self.author = '' ; 
      self.likes = '0' ; self.dislikes = '0' ; self.views = '0'
    end
  end
   
  def parse_duration(d)
    hr  = (d / 3600).floor
    min = ((d - (hr * 3600)) / 60).floor
    sec = (d - (hr * 3600) - (min * 60)).floor
   
    hr  = '0' + hr.to_s  if hr.to_i  < 10
    min = '0' + min.to_s if min.to_i < 10
    sec = '0' + sec.to_s if sec.to_i < 10
   
    if hr == '00'
      min.to_s + ':' + sec.to_s
    else
      hr.to_s + ':' + min.to_s + ':' + sec.to_s
    end
  end

  def parse_count(num)
    str = num.to_s
    if str.length <= 6
      parse = str.reverse.scan(/.{1,3}/).join(',').reverse
    elsif str.length > 6
      if (num % 1000000) < 5000
        str = (num / 1000000).to_s
      else
        str = (num.to_f / 1000000.to_f).round(2).to_s 
      end
      parse = str  + " mil"
    end
    
    parse
  end
end
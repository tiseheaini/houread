module HomeHelper
  def sample_topic
    sample_topic = Topic.select('title, timeint').sample
    encoding_site = Topic.encoding(sample_topic.timeint)
    share_site = "http://www.shiyueqingxin.com/yuedu/" + encoding_site
    link_to(sample_topic.title, share_site )
  end
end

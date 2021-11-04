module ApplicationHelper
  
  def get_avatar(profile_id)
    "/avatars/avatar#{profile_id}.png"
  end
  
  def summarize_text(text,limit=42)
    summarize=text[0..limit]
    summarize+="..." if(text.size >= limit)
    summarize
  end
  
end

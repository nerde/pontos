module PeriodsHelper
  def periods_for(periods, day, morning=false)
    periods.select do |p|
      p.day.strftime('%-d') == day.to_s && (morning ? p.start < '12:00' :
          p.start >= '12:00')
    end
  end

  def show_period(period, day, morning=false)
    if period
      content = "
          <td>#{link_to period.start, edit_period_path(period)}</td>
          <td>#{link_to period.finish, edit_period_path(period)}</td>
          <td>#{link_to icon_tag('trash'), period, method: :delete, confirm: t(:confirm)}</td>"
    else
      set_label = t(:set_period)
      content = "
          <td colspan=\"3\"> #{link_to set_label, new_specific_period_path(day,
              morning)}</td>"
    end
    content.html_safe
  end

  def new_specific_period_path(day, morning = false)
    params = ["day=#{day}"]
    params << "morning=1" if morning
    new_period_path + "?" + params.join('&')
  end

  def link_to_month(text, month)
    link_to text, periods_path + "?base=" + month.strftime('%Y-%m')
  end

  def formatted_time(time)
    negative = time < 0 && time *= -1
    hours = (time / 3600).to_i
    minutes = (time.to_i % 3600) / 60
    minutes = minutes * -1 if minutes < 0
    "#{'- ' if negative}%0.0f:%02.0f" % [hours, minutes]
  end
end

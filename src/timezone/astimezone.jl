timezone(x::ZonedDateTime) = x.timezone

function astimezone(x::TimeDateZone, tz::FixedTimeZone)
    on_date = ondate(x)
    at_time = attime(x)
    fast_time = fasttime(at_time)
    old_zone = atzone(x)
    
    old_offset_from_ut = offset.zone.std + offset.zone.dst
    new_offset_from_ut = offset.zone.std + offset.zone.dst
    
    zdt = ZonedDateTime(x)
    zdt = astimezone(zdt, tz)
    tdz = TimeDateZone(zdt)
    
    if old_offset_from_ut <= new_offset_from_ut
        tdz = tdz + fast_time
    else
        tdz = tdz - fast_time
    end
    
    return tdz
end

function astimezone(x::TimeDate, tz::TimeZone)
    tdz = TimeDateZone(x)
    return astimezone(tdz, tz)
end

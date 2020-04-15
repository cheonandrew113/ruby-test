require './award'


# calling a as "award"
def update_blue_star_quality(a)
  if a.expires_in > 0
    #  quality reduces by 2 before exp
    a.quality -= 2
  else
    # Quality reduces by 4 after exp
    a.quality -= 4
  end

  # time decrementation
  a.expires_in -= 1

  # quality cannot be negative, so return positive val
  a.quality=a.quality <= 0 ? 0 :  a.quality

  a
end

def update_quality(awards)
  awards.each do |a|

    return update_blue_star_quality(a) if a.name == 'Blue Star'

    if a.name != 'Blue First' && a.name != 'Blue Compare'
      if a.quality > 0
        if a.name != 'Blue Distinction Plus'
          a.quality -= 1
        end
      end
    else
      if a.quality < 50
        a.quality += 1
        if a.name == 'Blue Compare'
          if a.expires_in < 11
            if a.quality < 50
              a.quality += 1
            end
          end
          if a.expires_in < 6
            if a.quality < 50
              a.quality += 1
            end
          end
        end
      end
    end
    if a.name != 'Blue Distinction Plus'
      a.expires_in -= 1
    end
    if a.expires_in < 0
      if a.name != 'Blue First'
        if a.name != 'Blue Compare'
          if a.quality > 0
            if a.name != 'Blue Distinction Plus'
              a.quality -= 1
            end
          end
        else
          a.quality = a.quality - a.quality
        end
      else
        if a.quality < 50
          a.quality += 1
        end
      end
    end
  end
end
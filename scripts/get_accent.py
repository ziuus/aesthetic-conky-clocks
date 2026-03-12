import sys
from PIL import Image
import colorsys

try:
    img = Image.open(sys.argv[1])
    img.thumbnail((100, 100))
    # Quantize to 8 colors to find dominant palettes
    img = img.convert('P', palette=Image.ADAPTIVE, colors=8).convert('RGB')
    colors = img.getcolors(10000)

    best_color = None
    max_score = -1

    for count, (r, g, b) in colors:
        h, s, v = colorsys.rgb_to_hsv(r/255.0, g/255.0, b/255.0)
        # Prioritize colors that are vibrant (saturation) and bright (value)
        # Ignore extremely dark or washed out colors
        if v > 0.4 and s > 0.3:
            score = (s * 2.0) + v
            if score > max_score:
                max_score = score
                best_color = (r, g, b)

    # Fallback to the brightest color if no vibrant colors exist
    if not best_color:
        best_color = max((c[1] for c in colors), key=lambda x: sum(x))
        
    print("{:02X}{:02X}{:02X}".format(*best_color))
except Exception as e:
    # Safe fallback cyan
    print("22D3EE")

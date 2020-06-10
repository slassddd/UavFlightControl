max =152;
for i = 1:max
    nColor = length(plotOpt.color);
    nStyle = length(plotOpt.linestyle);
    idx_color = rem(i,nColor)+1;
    idx_style = ceil(i/nColor);
    idx_color = rem(idx_color,nColor) + 1;
    idx_style = rem(idx_style,nStyle) + 1;
    plot(sin([1:10]+rand(1,10)),'color',plotOpt.color{idx_color},'linestyle',plotOpt.linestyle{idx_style});hold on;
end
function V = interpol(w,h,img,Xq,Yq,type)
% INTERPOL   2-D Interpolation.
%    V = INTERPOL(width,height,img,Xq,Yq,type) interpoliert die 2-D Matrix 
%    img auf die neuen Koordinaten von Xq und Yq um daraus die neue Matrix
%    V zu bilden.
%   
%   img und Xq und Yq müssen dieselbe Dimension besitzen und dabei width
%   und height entsprechen
%
%   type legt die Interpolationsart fest. Zur Auswahl stehen:
%     'nearest' - Nächste-Nachbar-Zuordnung
%     'bilinear' - Bilineare Interpolation
%   
%   Unterstütze Klassen für die Eingabeparameter width, height, V, Xq, Yq:
%      float: double, single

% Vorinitialisieren der Ergebnismatrix V
V = zeros(h,w);

% Interpolationskoordinaten auf die Bildgrenzen beschränken
Xq = max(1, min(Xq, w-1));
Yq = max(1, min(Yq, h-1));

% Interpolationsart wählen und durchführen
if type == "bilinear"  % Bilineare Interpolation

    % Indizes der umgebenden Pixel der Zielkoordinaten berechnen
    x_floor = floor(Xq);
    y_floor = floor(Yq);
    x_ceil = ceil(Xq);
    y_ceil = ceil(Yq);
    
    % Abstand der neuen Koordinate zum jeweils linken bzw. oberen Pixel
    x_dist = Xq - x_floor;
    y_dist = Yq - y_floor;

    V = img(sub2ind([h,w],y_floor,x_floor)).* (1-x_dist).* (1-y_dist) +...
        img(sub2ind([h,w],y_floor,x_ceil)) .* x_dist    .* (1-y_dist) +...
        img(sub2ind([h,w],y_ceil,x_floor)) .* (1-x_dist).* y_dist +...
        img(sub2ind([h,w],y_ceil,x_ceil))  .* x_dist    .* y_dist;

elseif type == "nearest"  % Nächste-Nachbar-Zuordnung
    x_round = round(Xq);
    y_round = round(Yq);
    V = img(sub2ind([h, w],y_round, x_round));
end

end

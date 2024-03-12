function [w1,w2,w3] = barycentric(px, py, x1, y1, x2, y2, x3, y3)
% BARYCENTRIC   Baryzentrische Koordinaten von Dreieckspunkten.
%
%   [w1,w2,w3,r] = BARYCENTRIC(px, py, x1, y1, x2, y2, x3, y3) berechnet 
%   die baryzentrischen Koordinaten ("Gewichte") w1, w2 und w3 der Punkte
%   innerhalb eines Dreiecks.
%
%   px und py sind die Koordinaten eines oder mehrerer Punkte.
%   Für eine 2-D Matrix ist es ein rechteckiges kartesisches 
%   Koordinatengitter (meshgrid) mit den Dimensionen der Matrix. 
%   (x1, y1), (x2, y2) und (x3, y3) sind die Eckpunkte des Dreiecks.
%
%   Unterstütze Klassen für die Eingabeparameter px,py,x1,y1,x2,y2,x3,y3:
%      float: double, single

% Um Vektorisierten Ansatz von Matlab zu nutzen:
% Matrizen der Größe von px, py mit Eckpunktkoordinaten befüllen
x1 = repmat(x1, size(px));
y1 = repmat(y1, size(px));
x2 = repmat(x2, size(px));
y2 = repmat(y2, size(px));
x3 = repmat(x3, size(px));
y3 = repmat(y3, size(px));

% Berechnung der Baryzentrischen Koordinaten (Gewichte) für die Punkte im
% Dreieck. Der Nenner entspricht der doppelten Dreiecksfläche.
% Der in MATLAB kleinstmögliche Wert mit doppelter Präzision (double), eps
% (=2.2204e-16), wird aufaddiert um Teilung durch Null zu verhindern.
denominator = ((x2-x1) .* (y3-y2) - (y2-y1) .* (x3-x2) + eps); 
w1 = ((x2-px) .* (y3-py) - (x3-px) .* (y2-py)) ./ denominator;
w2 = ((x3-px) .* (y1-py) - (x1-px) .* (y3-py)) ./ denominator;
w3 = 1 - w1 - w2;

% Berechnung der Maskierungsmatrix r. Haben die Koordinaten einen Wert 
% zwischen 0 und 1, liegen die entsprechenden Punkte innerhalb des Dreiecks
% und r (Maskierungsmatrix) ist 1, ansonsten 0.
r = (w1>=0) & (w2>=0) & (w3>=0) & (w1<=1) & (w2<=1) & (w3<=1);

% Null setzen aller Werte außerhalb des Dreiecks
w1=w1.*r;
w2=w2.*r;
w3=w3.*r;

end

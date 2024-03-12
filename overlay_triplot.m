function overlay = overlay_triplot(img,width,height,triImg,xImg,yImg,vis)
% OVERLAY_TRIPLOT  
%    overlay_triplot(img_in,width,height,triImg,xImg,yImg) überlagert ein 
%    Bild mit dem Delaunay-Dreiecksnetz zu Darstellungszwecken.
%
%    img_in ist ein Grauwert- oder RGB-Bild mit den Dimensionen width und
%    height. xImg und yImg sind die Koordinaten der Dreieckseckpunkte, 
%    zugehörend zum Bild img_in. triImg die Ausgabe der Delaunay-
%    Triangulierungsfunktion delaunay().
%
%    OVERLAY_TRIPLOT macht sich die Möglichkeiten der triplot()-Funktion 
%    und der Verwendung eines Hintergrundbilds in einem Plot zunutze.
%    Der breite graue Bereich um einen Plot wird mit einstellbaren Faktoren
%    abgeschnitten.

if ~vis
    set(0,'DefaultFigureVisible','off')
end
axis equal
set(gca, 'YDir','reverse');
set(gcf,'position',[0,0,width,height]);
xlim([0 width]); % Skalen der Plotachsen an Bilddimension anpassen
ylim([0 height]);
% Zwischenbild als Hintergrund für den Plot verwenden
image('CData',uint8(img),'XData',[0 width],'YData',[0 height]);
hold on
triplot(triImg,xImg,yImg,"g"); % Dreiecksnetz plotten
hold off
F = getframe(gcf);
[overlay, ~] = frame2im(F); % Plot in Bildmatrix umwandeln
szC_out = size(overlay);
% Graue Plotumrahmung beschneiden
overlay = imcrop(overlay, ...
    [0.02*width, 0.06*height, 0.97*szC_out(2), 0.94*szC_out(1)]); % +/-0.4
set(0,'DefaultFigureVisible','on')
end


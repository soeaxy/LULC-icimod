<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" version="3.16.8-Hannover" minScale="1e+08" maxScale="0">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
  </flags>
  <temporal mode="0" fetchMode="0" enabled="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <customproperties>
    <property key="WMSBackgroundLayer" value="false"/>
    <property key="WMSPublishDataSourceUrl" value="false"/>
    <property key="embeddedWidgets/count" value="0"/>
    <property key="identify/format" value="Value"/>
  </customproperties>
  <pipe>
    <provider>
      <resampling maxOversampling="2" enabled="false" zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour"/>
    </provider>
    <rasterrenderer band="1" opacity="1" type="paletted" alphaBand="-1" nodataColor="">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <colorPalette>
        <paletteEntry label="Forests" color="#156800" alpha="255" value="0"/>
        <paletteEntry label="Lake" color="#b5c4ff" alpha="255" value="1"/>
        <paletteEntry label="Bare slopes" color="#deab13" alpha="255" value="2"/>
        <paletteEntry label="Agriculture" color="#f8ff37" alpha="255" value="3"/>
        <paletteEntry label="Sandy area" color="#d9acec" alpha="255" value="4"/>
        <paletteEntry label="River path" color="#142898" alpha="255" value="5"/>
        <paletteEntry label="Snow cover" color="#4decef" alpha="255" value="6"/>
        <paletteEntry label="Residential" color="#ff0101" alpha="255" value="7"/>
      </colorPalette>
      <colorramp type="randomcolors" name="[source]"/>
    </rasterrenderer>
    <brightnesscontrast gamma="1" brightness="0" contrast="0"/>
    <huesaturation saturation="0" grayscaleMode="0" colorizeOn="0" colorizeRed="255" colorizeBlue="128" colorizeGreen="128" colorizeStrength="100"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>

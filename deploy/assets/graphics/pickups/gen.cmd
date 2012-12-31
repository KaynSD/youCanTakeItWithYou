@echo off
setlocal ENABLEDELAYEDEXPANSION
set out_file= ../AssetsAuto.as
set assets_path=\assets
cd %CD%%assets_path%
echo     // script generated file 							> %out_file%
echo		package assets 								>> %out_file% >> %out_file%						
echo		{									>> %out_file% >> %out_file%	
echo			import com.p3.loading.bundles.P3InternalBundle;				>> %out_file% >> %out_file%	
echo			public class AssetsAuto extends P3InternalBundle  		>> %out_file% >> %out_file%	
echo			{ 								>> %out_file% >> %out_file%
for /d %%x in (./*) do for /f %%a IN ('dir %%x /b  *') do (  
if /i "%%~xa"==".jpeg" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="image/jpeg"^)] public var img_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".png" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="image/png"^)] public var img_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".gif" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="image/gif"^)] public var img_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".svg" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="image/svg"^)] public var svg_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".mp3" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="audio/mpeg"^)] public var mp3_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".wav" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="audio/mpeg"^)] public var wav_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".txt" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="application/octet-stream"^)] public var txt_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".xml" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="application/octet-stream"^)] public var xml_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".ttf" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="application/x-font-truetype"^)] public var font_%%~na:Class; >> %out_file% >> %out_file%
if /i "%%~xa"==".swf" 	echo     	[Embed^(source="%%~nx/%%a",mimeType="application/x-shockwave-flash"^)] public var swf_%%~na:Class; >> %out_file% >> %out_file%
::echo		[Embed^(source="%%~nx/%%a",mimeType="application/octet-stream"^)] >> %out_file% >> %out_file%
echo     	^(source="%%~nx/%%a"^) %%~xa )	
echo				public function AssetsAuto() 				>> %out_file% >> %out_file%
echo				{							>> %out_file% >> %out_file%
echo					super();					>> %out_file% >> %out_file%
echo				}							>> %out_file% >> %out_file%
echo			} 								>> %out_file% >> %out_file%	
echo		} 									>> %out_file% >> %out_file%
pause

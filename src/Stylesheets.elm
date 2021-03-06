port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Component.Board as Board 
import Main exposing (cssFileName)

port files : CssFileStructure -> Cmd msg

cssFiles : CssFileStructure
cssFiles = Css.File.toFileStructure [ ( cssFileName , Css.File.compile [ Board.css ] ) ]


main : CssCompilerProgram
main = Css.File.compiler files cssFiles
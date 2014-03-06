require "sketchup.rb"
require "extensions.rb"

#-------------------------------------------------------------------------------

module TT
 module Plugins
  module ShaderTools

  ### CONSTANTS ### ------------------------------------------------------------

  # Plugin information
  PLUGIN_ID       = "ShaderTools".freeze
  PLUGIN_NAME     = "Shader Tools".freeze
  PLUGIN_VERSION  = "1.0.0".freeze

  # Resource paths
  FILENAMESPACE = File.basename(__FILE__, ".*")
  PATH_ROOT     = File.dirname(__FILE__).freeze
  PATH          = File.join(PATH_ROOT, FILENAMESPACE).freeze
  PATH_IMAGES   = File.join(PATH, "images").freeze
  PATH_SHADERS  = File.join(PATH, "shaders").freeze


  ### EXTENSION ### ------------------------------------------------------------

  unless file_loaded?(__FILE__)
    loader = File.join( PATH, "core.rb" )
    ex = SketchupExtension.new(PLUGIN_NAME, loader)
    ex.description = "Changes the face material based on shader types."
    ex.version     = PLUGIN_VERSION
    ex.copyright   = "Thomas Thomassen © 2014"
    ex.creator     = "Thomas Thomassen"
    Sketchup.register_extension(ex, true)
  end

  end # module ShaderTools
 end # module Plugins
end # module TT

#-------------------------------------------------------------------------------

file_loaded(__FILE__)

#-------------------------------------------------------------------------------

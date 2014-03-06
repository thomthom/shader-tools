module TT::Plugins::ShaderTools

  require File.join(PATH_SHADERS, "base_shader.rb")
  require File.join(PATH_SHADERS, "normal_shader.rb")

### UI ### ---------------------------------------------------------------------

  unless file_loaded?(__FILE__)
    # Commands
    cmd = UI::Command.new("Shade by Normal") {
      self.shade(NormalShader)
    }
    cmd.small_icon = File.join(PATH_IMAGES, 'NormalMapping_16.png')
    cmd.large_icon = File.join(PATH_IMAGES, 'NormalMapping_24.png')
    cmd.tooltip = "Shade by Normal"
    cmd.status_bar_text = "Shade each face based on it's normal."
    cmd_shade_by_normal = cmd

    # Menus
    menu = UI.menu("Plugins").add_submenu(PLUGIN_NAME)
    menu.add_item(cmd_shade_by_normal)

    # Toolbar
    toolbar = UI::Toolbar.new(PLUGIN_NAME)
    toolbar.add_item(cmd_shade_by_normal)
    toolbar.restore
  end


  ### Extension ### ------------------------------------------------------------

  def self.shade(shader_klass)
    model = Sketchup.active_model
    entities = model.active_entities
    faces = entities.grep(Sketchup::Face)

    if faces.empty?
      UI.messagebox("No faces found. This plugin does not dig into " <<
        "sub-groups/components.")
      return
    end

    time = Time.now

    shader = shader_klass.new
    model.start_operation(shader.name, true)
    Sketchup.status_text = "Shading using #{shader.name} - please wait..."
    entities.grep(Sketchup::Face) { |face|
      material = shader.shade(face)
    }
    model.commit_operation

    elapsed_time = Time.now - time
    Sketchup.status_text = "Shading took %.4f seconds" % elapsed_time
    puts "Shading took %.4f seconds" % elapsed_time
  end


  ### DEBUG ### ----------------------------------------------------------------

  # TT::Plugins::ShaderTools.reload
  #
  # @since 1.0.0
  def self.reload
    original_verbose = $VERBOSE
    $VERBOSE = nil
    filter = File.join(PATH, "*.{rb,rbs}")
    files = Dir.glob(filter).each { |file|
      load file
    }
    files.length
  ensure
    $VERBOSE = original_verbose
  end

end # module

#-------------------------------------------------------------------------------

file_loaded(__FILE__)

#-------------------------------------------------------------------------------

[ $libhello.linker_name, $libhello.soname ].each do | each |
  file each do | task |
    symlink $libhello.target_file_name, task.name
  end

  CLOBBER.include each if FileTest.exists?( each )
end

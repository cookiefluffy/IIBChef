log "================== IBM Integration Bus Toolkit is about to installed ===================" do
  level :info
end


# download toolkit image
remote_file "#{Chef::Config[:file_cache_path]}/9.0.0-IIB-LINUXX64-DEVELOPER-TOOLKIT.tar.gz" do
	source "ftp://hurgsa.ibm.com/home/j/r/jreeve/iib/9.0.0-IIB-LINUXX64-DEVELOPER-TOOLKIT.tar.gz"
	action :create_if_missing
end

#unzip image
bash "unpack image" do
	user "root"
	flags "-e"
	code <<-EOS
	rm -rf "#{Chef::Config[:file_cache_path]}/image"
	mkdir -p "#{Chef::Config[:file_cache_path]}/image"
	tar -xzf "#{Chef::Config[:file_cache_path]}/9.0.0-IIB-LINUXX64-DEVELOPER-TOOLKIT.tar.gz" --strip-components=1 -C "#{Chef::Config[:file_cache_path]}/image"
	EOS
end

#run silent install shell script
bash "install_iib_toolkit" do
	user "root"
	flags "-e"
	return [0,127]
	code <<-EOS
	cd "#{Chef::Config[:file_cache_path]}/image"
	sudo ./installToolkit -i silent -DLICENSE_ACCEPTED=TRUE
	EOS
end

JsOsaDAS1.001.00bplist00�Vscript_�function run(input, parameters) {
	const tmpDir = '/tmp'
	const exportDir = tmpDir + '/exportDir'
	const exportPath = Path(exportDir)
			
	Finder = Application('Finder')
	
	SystemEvents = Application("System Events")
	
	Photos = Application('Photos')
	Photos.includeStandardAdditions = true

	app = Application.currentApplication()
	app.includeStandardAdditions = true
	
	selection = Photos.selection()
	if (selection.length === 0) {
		return
	}

	Photos.export(selection, {to: exportPath, usingOriginals: false})

	app.doShellScript(`cd ${exportPath}; for i in *.jpeg; do sips -s format jpeg -s formatOptions 95 "\${i}" --out "\${i}"; done`)

	sourceFolder = SystemEvents.aliases.byName(exportDir);

	diskItems = sourceFolder.diskItems().filter(item => {
		const regex = /\.jpeg$/;
		let m;

		return regex.exec(item) !== null
	})
	
	Photos = Application('Photos')
	Photos.import(diskItems, {skipCheckDuplicates: true})
	
	Finder.delete(exportPath)
}                              � jscr  ��ޭ
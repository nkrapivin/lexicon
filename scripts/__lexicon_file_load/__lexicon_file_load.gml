// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __lexicon_file_load(_file) {
	var _buffer = 0;
	if (_file.isLoaded == true) return;
	if (_file.isAsync == true) {
		_buffer = buffer_create(1, buffer_grow, 1);
		var _id = buffer_load_async(_buffer, _file.fileName, 0, -1);
		LEXICON_STRUCT.fileAsyncList[array_length(LEXICON_STRUCT.fileAsyncList)] = [_id, _buffer, _file];
	} else {
		_buffer = buffer_load(_file.fileName);
		if (_buffer = -1) {
			__lexicon_throw("Invalid file " + string(_file.fileName));
			return;
		}
		
		var _string = buffer_read(_buffer, buffer_text);
		
		var _args;
		_args[0] = _string;
		
		if (_file.args != undefined) {
			array_copy(_args, 1, _file.args, 0, array_length(_file.args));	
		}
		
		script_execute_ext(_file.fileType, _args);
	}
}
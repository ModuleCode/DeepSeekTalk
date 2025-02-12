extends HTTPRequest
class_name TTSRequest
signal loading_over()



const header=["Content-Type: application/json"]
var audio_stream:AudioStreamWAV= AudioStreamWAV.new()
func tts_request(ip:String,text:String):
	var request_json={
	"text": text,
	"text_lang":"zh",
	"ref_audio_path": "D:/Other/temp/买东西那天也有一个人帮了开了款式，那个人好像叫.wav",         # str.(required) reference audio path
	"aux_ref_audio_paths": [],    # list.(optional) auxiliary reference audio paths for multi-speaker synthesis
	"prompt_text": "买东西那天也有一个人帮了开了款式，那个人好像叫",            # str.(optional) prompt text for the reference audio
	"prompt_lang": "zh",            # str.(required) language of the prompt text for the reference audio
	"top_k": 5,                   # int. top k sampling
	"top_p": 1,                   # float. top p sampling
	"temperature": 1,             # float. temperature for sampling
	"text_split_method": "cut5",  # str. text split method, see text_segmentation_method.py for details.
	"batch_size": 1,              # int. batch size for inference
	"batch_threshold": 0.75,      # float. threshold for batch splitting.
	"split_bucket": true,
	"return_fragment": false,
	"speed_factor":1.0,           # float. control the speed of the synthesized audio.
	"streaming_mode": true,      # bool. whether to return a streaming response.
	"seed": -1,                   # int. random seed for reproducibility.
	"parallel_infer": false,       # bool. whether to use parallel inference.
	"repetition_penalty": 1.35    # float. repetition penalty for T2S model.
	}
	request(ip,header,HTTPClient.METHOD_POST,JSON.stringify(request_json))	
	pass
	
	
func tts_request_api1(ip:String,text:String):
	var request_json={
		"text": text,
		"text_language": "zh",
		#"inp_refs": ["audios/huke/平静说话-虎克看到黑色头发的大哥哥，被蓝色头发的叔叔带去搏击俱乐部了。.wav","audios/huke/开心-希儿姐姐说话声音很大，但有时却说不过虎克呢，嘿嘿~.wav"],
		"refer_wav_path": "audios/孔海应.wav",
		"prompt_text": "叫孔海英，我是金熙泽的妈妈",
		"prompt_language": "zh"
	}
	request(ip,header,HTTPClient.METHOD_POST,JSON.stringify(request_json))	
	pass
func  _ready() -> void:
	request_completed.connect(tts_request_finished)
func tts_request_finished(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	audio_stream.data=body
	audio_stream.mix_rate=32000
	audio_stream.format=1
	loading_over.emit()

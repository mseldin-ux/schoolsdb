<?php 

class CGMSDBForm {
	public $templates;
	public $valuelists;
	public $checklists;
	public $onetimevalues;
	public function __construct($formpath) {
		$matches=Array();
		$valuelists=Array();
		$this->onetimevalues=Array();
		$section='header';
		$pattern='/XXXXX ([^ ]+) XXXXX/';
		$this->templates=Array();
		$this->checklists=Array();
		
		$lines = file($formpath);
		$inarray=false;
		foreach ($lines as $line) {
			if (preg_match($pattern,$line,$matches)>0) {
				$inarray=false;
				$section=$matches[1];
				if ($section == "check-lists") {
					$inarray=true;
				}
				if (substr($section,0,5) == "list-") {
					$inarray=true;
					$this->templates[$section]=Array();
				}
			}
			else {
				if ($inarray) {
					$line=chop($line);
					if (strlen($line)>1) {
						if ($section == "check-lists") {
							$this->checklists[$line]=1;
						}
						else {
							array_push($this->templates[$section],$line);
						}
					}
				}
				else {
					if (!array_key_exists($section,$this->templates)) {
						$this->templates[$section]="";
					}
					$this->templates[$section].=$line;
				}
			}
		}
		//echo $this->templates['run']."\n<br>";
		//return $this;

	}
	public function debugTemplates() {
		foreach ($this->templates as $template => $text) {
			print "template is $template \n<br>";
			print $text."\n<hr>";
		}
	}
	public function setOneTimeValue($key,$val) {
		$this->onetimevalues[$key]=$val;
	}
	
	public function renderTemplate($templatename,$dbobj) {
		echo $this->getTemplateAsString($templatename,$dbobj);
	}
	public function getTemplateAsString($templatename,$dbobj) {
		$template = $this->templates[$templatename];
		if (is_array($template)) {
			return $template;
		}
		$values = $this->onetimevalues;
		$this->onetimevalues = [];
		$escape = static fn ($value) => htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
		// A single pass prevents stored text from being interpreted as another template.
		return preg_replace_callback('/<<<([a-z0-9_-]+)>>>/i', function ($match) use ($dbobj, $values, $escape) {
			$key = $match[1];
			if (array_key_exists($key, $values)) {
				return (string) $values[$key];
			}
			if (isset($this->checklists[$key])) {
				return '<input type="checkbox" name="' . $escape($key) . '"'
					. ($dbobj->getValue($key) > 0 ? ' checked' : '') . '>';
			}
			if (str_starts_with($key, 'list-') && isset($this->templates[$key])) {
				$field = substr($key, 5);
				$options = '';
				foreach ($this->templates[$key] as $item) {
					$options .= '<option' . ($item === $dbobj->getValue($field) ? ' selected' : '') . '>'
						. $escape($item) . '</option>';
				}
				return $options;
			}
			return $escape($dbobj->getValue($key));
		}, $template);
	}



}

?>

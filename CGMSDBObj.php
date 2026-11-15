<?php

require_once __DIR__ . '/includes/config.php';

class CGMSDBObj {
	public $debug;
	public $mysqli;
	public $fieldvalues;
	public $changedfields;
	public $requiredfields;
	public $fieldtypes;
	public $tablename;
	public $keyfield;
	public $currentboundfields;
	public $currentstmt;
	public function __construct($tablename, ?mysqli $connection = null) {
		$this->quoteIdentifier($tablename);
		$this->tablename=$tablename;
		$this->mysqli = $connection ?? schoolsDbConnect();
		$this->fieldtypes=Array();
		$this->requiredfields=Array();
		$this->init();
		$this->reset();
		$this->debug=false;
	}
	public function reset() {
		$this->fieldvalues=Array();
		$this->changedfields=Array();
	}
	
	public function setValue($field,$val) {
		if ($this->debug) {
			foreach ($this->fieldvalues as $f => $g) {
				error_log("))$f => $g \n");
			}
			echo " in2: $val\n<br>";
		}
		if (! array_key_exists($field,$this->fieldtypes)) {
			throw new InvalidArgumentException("Unknown field '$field' in {$this->tablename}.");
		}
		if ($val !== null && $this->fieldtypes[$field]!="s" && (! is_numeric($val))) {
			$val=strtolower($val);
			if ($val == "true" || $val =="checked" || $val=="on") {
				$val=1;
			}
			else {$val=0;}
		}
		
		$val = $val === null ? null : (string) $val;
		$current = $this->fieldvalues[$field] ?? null;
		$current = $current === null ? null : (string) $current;
		if (!array_key_exists($field,$this->fieldvalues) || $current !== $val) {
			if ($this->debug) {echo " &nbsp; Xetting $field to $val\n<br/>";}
			$this->fieldvalues[$field]=$val;
			$this->changedfields[$field]=true;
		} 
		else {
			if ($this->debug) {
				echo "ERR 8! (".$field.")\n<br/>";
				echo "\n".$this->fieldvalues[$field]." -- ".$val."\n<br/>";
				echo "\nSTRCMP: ".strcmp($this->fieldvalues[$field],$val)."\n<br/>";
			}
		}
		#print "<br/>setting $field to $val<br/>";
	}
	
	public function getValue($field) {
		if (!array_key_exists($field,$this->fieldvalues)) {
			return "";
		}
		return $this->fieldvalues[$field];
	}
	
	public function getFieldNames() {
		$arr=array_keys($this->fieldtypes);
		return $arr;
	}
	
	public function init() {
		#echo "Hello world!".(5*100*4);
		$this->keyfield="id";
		return;
		$this->fieldvalues['schoolname']="bar";
		$this->changedfields['schoolname']=true;
		$this->fieldtypes['schoolname']="s";
		$this->fieldvalues['contactname']="a person";
		$this->changedfields['contactname']=true;
		$this->fieldtypes['contactname']="s";
		
		$this->fieldvalues['infants']=1;
		$this->changedfields['infants']=true;
		$this->fieldtypes['infants']="i";
		
		$this->fieldvalues['infoemail']="foo@bar.com";
		$this->changedfields['infoemail']=true;
		$this->fieldtypes['infoemail']="s";
		
		$this->fieldvalues['address1']="somewhere";
		$this->changedfields['address1']=true;
		$this->fieldtypes['address1']="s";
		$this->fieldvalues['city']="somewhere";
		$this->changedfields['city']=true;
		$this->fieldtypes['city']="s";
		$this->fieldvalues['stateprovince']="somewhere";
		$this->changedfields['stateprovince']=true;
		$this->fieldtypes['stateprovince']="s";
		$this->fieldvalues['zippostal']="somewhere";
		$this->changedfields['zippostal']=true;
		$this->fieldtypes['zippostal']="s";
		$this->fieldvalues['country']="somewhere";
		$this->changedfields['country']=true;
		$this->fieldtypes['country']="s";
		$this->fieldtypes['deleted']="i";
		$this->fieldvalues['deleted']=0;
		$this->fieldtypes['deleteddate']="s";
		$this->fieldvalues['deleteddate']="1-1-1990";
		
		$str_sql_uncommitted="set transaction isolation level READ UNCOMMITTED;";	
		$stmt = $this->mysqli->prepare($str_sql_uncommitted);
		$stmt->execute();
			
	}
	
	public function delete() {
		$str_sql_delete="delete from ".$this->quoteIdentifier($this->tablename)." where ".$this->quoteIdentifier($this->keyfield)."=?";
		$stmt = $this->mysqli->prepare($str_sql_delete);
		$this->bindValues($stmt, [$this->fieldvalues[$this->keyfield]], $this->fieldtypes[$this->keyfield]);
		$stmt->execute();
		return $stmt->error;
	}
	public function execraw($strsql) {
		$stmt = $this->mysqli->prepare($strsql);
		$stmt->execute();
		return $stmt->error;
	}
	
	
	public function update() {
		$assignments = [];
		$values = [];
		$types = '';
		foreach ($this->changedfields as $fname => $fval) {
			if ($fval) {
				$assignments[] = $this->quoteIdentifier($fname) . ' = ?';
				$values[] = $this->fieldvalues[$fname];
				$types .= $this->fieldtypes[$fname];
			}
		}
		if ($assignments === []) {
			return '';
		}
		$str_sql_update = 'UPDATE ' . $this->quoteIdentifier($this->tablename)
			. ' SET ' . implode(', ', $assignments)
			. ' WHERE ' . $this->quoteIdentifier($this->keyfield) . ' = ?';
		$values[] = $this->fieldvalues[$this->keyfield];
		$types .= $this->fieldtypes[$this->keyfield];
		$stmt = $this->mysqli->prepare($str_sql_update);
		$this->bindValues($stmt, $values, $types);
		$stmt->execute();
		$error = $stmt->error;
		$stmt->close();
		$this->changedfields = array_fill_keys(array_keys($this->fieldtypes), false);
		return $error;
	}
	public function getLastError() {
		return $this->mysqli->error;
	}
	
	public function countRows($hasharray, array $params = []) {
		if (is_array($hasharray)) {
			[$where, $params, $types] = $this->equalityWhere($hasharray);
		} else {
			$where = $hasharray;
			$types = str_repeat('s', count($params));
		}
		$sql = 'SELECT COUNT(*) FROM ' . $this->quoteIdentifier($this->tablename);
		if (trim($where) !== '') {
			$sql .= ' WHERE ' . $where;
		}
		$stmt = $this->mysqli->prepare($sql);
		$this->bindValues($stmt, $params, $types);
		$stmt->execute();
		$stmt->bind_result($count);
		$stmt->fetch();
		$stmt->close();
		return (int) $count;
	}
	public function findRow($hasharray,$orderarray,$offset=0,$limit=0) {
		[$where, $params, $types] = $this->equalityWhere($hasharray);
		$sql = $this->selectColumns();
		if ($where !== '') {
			$sql .= ' WHERE ' . $where;
		}
		$order = [];
		foreach ($orderarray as $field => $direction) {
			if (!array_key_exists($field, $this->fieldtypes)) {
				throw new InvalidArgumentException("Unknown sort field: $field");
			}
			$direction = strtoupper($direction);
			if (!in_array($direction, ['ASC', 'DESC'], true)) {
				throw new InvalidArgumentException('Invalid sort direction.');
			}
			$order[] = $this->quoteIdentifier($field) . ' ' . $direction;
		}
		if ($order !== []) {
			$sql .= ' ORDER BY ' . implode(', ', $order);
		}
		return $this->startSelect($sql . $this->pagination($offset, $limit), $params, $types);
	}
	
	
	public function selectSQL($wherestatement,$offset=0,$limit=0, array $params = []) {
		$sql = $this->selectColumns();
		if (trim($wherestatement) !== '') {
			$sql .= ' WHERE ' . $wherestatement;
		}
		return $this->startSelect($sql . $this->pagination($offset, $limit), $params, str_repeat('s', count($params)));
  }
	
	public function nextRecordInSet() {
		$row=$this->currentstmt->fetch();
		if (! $row) {return false;}
		foreach ($this->currentboundfields as $k=>$v) {
	   	$this->fieldvalues[$k]=$v;
	   	#echo $k."=".$v."\n<br>";
	  }
	  return $row;
	}
	
	
	public function getRow($id) {
		return $this->findRow([$this->keyfield => $id], [], 0, 1);
	}
	
	public function insert() {
		$columns = [];
		$values = [];
		$types = '';
		foreach ($this->changedfields as $fname => $fval) {
			if ($fval) {
				$columns[] = $this->quoteIdentifier($fname);
				$values[] = $this->fieldvalues[$fname];
				$types .= $this->fieldtypes[$fname];
			}
		}
		if ($columns === []) {
			return 'Nothing to save.';
		}
		$str_sql_insert = 'INSERT INTO ' . $this->quoteIdentifier($this->tablename)
			. ' (' . implode(', ', $columns) . ') VALUES ('
			. implode(', ', array_fill(0, count($values), '?')) . ')';
		$stmt = $this->mysqli->prepare($str_sql_insert);
		$this->bindValues($stmt, $values, $types);
		$stmt->execute();
		$this->fieldvalues[$this->keyfield]=$this->mysqli->insert_id;
		$error = $stmt->error;
		$stmt->close();
		$this->changedfields = array_fill_keys(array_keys($this->fieldtypes), false);
		return $error;
	}


	public function setUpTable() {
		$str_sql_select="describe ".$this->quoteIdentifier($this->tablename);
		if ($this->debug) {echo "<p/>".$str_sql_select;}
		$res=$this->mysqli->query($str_sql_select);
		while ($row=$res->fetch_assoc()) {
			
			$name=$row['Field'];
			$this->fieldvalues[$name]=NULL;
			if ($row['Key']=="PRI") {$this->keyfield=$name;}
			#print "'".$name. "' = ".$row['Type']."\r\n<br/>";
			if (strpos($row['Type'],"int")===false && $row['Type'] != "float") {
				$this->fieldtypes[$name]="s";
			}
			else if ($row['Type'] == "float") {
				$this->fieldtypes[$name]="d";
			}
			else {
				$this->fieldtypes[$name]="i";
			}
			if ($row['Null'] == "NO") {
				$this->requiredfields[$name]=true;
			}
			else {
				$this->requiredfields[$name]=false;
			}
			$this->changedfields[$name]=false;
		}
	}

	private function quoteIdentifier(string $name): string {
		if (!preg_match('/^[A-Za-z0-9_]+$/D', $name)) {
			throw new InvalidArgumentException('Invalid SQL identifier.');
		}
		return '`' . $name . '`';
	}

	private function bindValues(mysqli_stmt $stmt, array $values, string $types): void {
		if ($values !== []) {
			$stmt->bind_param($types, ...$values);
		}
	}

	private function equalityWhere(array $conditions): array {
		$clauses = [];
		$values = [];
		$types = '';
		foreach ($conditions as $field => $value) {
			if (!array_key_exists($field, $this->fieldtypes)) {
				throw new InvalidArgumentException("Unknown field: $field");
			}
			$clauses[] = $this->quoteIdentifier($field) . ' = ?';
			$values[] = $value;
			$types .= $this->fieldtypes[$field];
		}
		return [implode(' AND ', $clauses), $values, $types];
	}

	private function selectColumns(): string {
		$columns = array_map($this->quoteIdentifier(...), array_keys($this->fieldtypes));
		return 'SELECT ' . implode(', ', $columns) . ' FROM ' . $this->quoteIdentifier($this->tablename);
	}

	private function pagination($offset, $limit): string {
		$offset = max(0, (int) $offset);
		$limit = max(0, (int) $limit);
		if ($offset === 0 && $limit === 0) {
			return '';
		}
		return ' LIMIT ' . ($limit > 0 ? $limit : PHP_INT_MAX) . ' OFFSET ' . $offset;
	}

	private function startSelect(string $sql, array $values, string $types): bool {
		if ($this->currentstmt !== null) {
			$this->currentstmt->close();
		}
		$this->currentstmt = $this->mysqli->prepare($sql);
		$this->bindValues($this->currentstmt, $values, $types);
		$this->currentstmt->execute();
		$this->currentstmt->store_result();
		$metadata = $this->currentstmt->result_metadata();
		$this->currentboundfields = [];
		$references = [];
		while ($field = $metadata->fetch_field()) {
			$this->currentboundfields[$field->name] = null;
			$references[] =& $this->currentboundfields[$field->name];
		}
		$metadata->free();
		$this->currentstmt->bind_result(...$references);
		$found = $this->currentstmt->fetch();
		foreach ($this->currentboundfields as $field => $value) {
			$this->fieldvalues[$field] = $value;
		}
		$this->changedfields = array_fill_keys(array_keys($this->fieldtypes), false);
		return $found === true;
	}
}

?>
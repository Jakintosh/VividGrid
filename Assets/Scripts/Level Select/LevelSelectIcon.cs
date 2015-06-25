﻿using UnityEngine;
using System.Collections;

public class LevelSelectIcon : MonoBehaviour {

	private LevelSelectZone _zone;

	public TextAsset levelData;

	public int levelID_ref;
	public LevelSelectZone Zone { get { return _zone; } }

	void Start() {
		_zone = transform.parent.GetComponent<LevelSelectZone>();
	}

	public void ButtonPressed () {
		Zone.LevelWasSelected(levelID_ref);
		// Debug.Log("Level Selected at " + Zone.zoneName + " " + levelID_ref);
	}
}
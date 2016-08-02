//
//  ViewController.swift
//  image-processor
//
//  Created by José-María Súnico on 20160624.
//  Copyright © 2016 José-María Súnico. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate{
	var lastSavedImage: UIImage = UIImage()
	var filteredImage: UIImage = UIImage()

	
	@IBOutlet weak var infoLabel: UILabel!
	
	@IBOutlet weak var imageScrollView: UIScrollView!
	@IBOutlet weak var myScrollView: UIScrollView!
	
	@IBOutlet weak var firstMenu: UIStackView!
	@IBOutlet weak var SecondMenu: UIView!
	@IBOutlet weak var filteredImageView: UIImageView!
	
	@IBOutlet weak var onNewLabel: UIButton!
	@IBOutlet weak var onShareLabel: UIButton!
	@IBOutlet weak var socialLabel: UIButton!
	@IBOutlet weak var filterButtonLabel: UIButton!
	@IBOutlet weak var compareButton: UIButton!
	
	@IBOutlet weak var filterSlider: UISlider!
	@IBOutlet weak var sliderValue: UILabel!
	
	@IBOutlet weak var brightButtonLabel: UIButton!
	@IBOutlet weak var contrastButtonLabel: UIButton!
	@IBOutlet weak var greyscaleButtonLabel: UIButton!
	@IBOutlet weak var inversionButtonLabel: UIButton!
	@IBOutlet weak var solarisationButtonLabel: UIButton!
	@IBOutlet weak var gammaButtonLabel: UIButton!
	@IBOutlet weak var redButtonLabel: UIButton!
	@IBOutlet weak var greenButtonLabel: UIButton!
	@IBOutlet weak var blueButtonLabel: UIButton!
	@IBOutlet weak var alphaButtonLabel: UIButton!
	@IBOutlet weak var scaleButtonLabel: UIButton!
	
	var currentFilter = "Identity"
	var currentParameter = "1"
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		dismissViewControllerAnimated(true, completion: nil)
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
			self.lastSavedImage = image
			softReset()
			self.filteredImage = self.lastSavedImage
			self.filteredImageView.image = self.filteredImage
		}
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	@IBAction func onShare(sender: AnyObject) {
		self.lastSavedImage = self.filteredImageView.image!
		self.filterButtonLabel.selected = false
		let activityController = UIActivityViewController(activityItems: [self.lastSavedImage], applicationActivities: nil)
		presentViewController(activityController, animated: true, completion: nil)
		softReset()
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
	}
	
	@IBAction func onNewPhoto(sender: AnyObject) {
		self.filterButtonLabel.selected = false
		let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
		actionSheet.addAction((UIAlertAction(title: "Camera", style: .Default, handler: { action in
			self.showCamera()
		})))
		actionSheet.addAction((UIAlertAction(title: "Album", style: .Default, handler: { action in
			self.showAlbum()
		})))
		actionSheet.addAction((UIAlertAction(title: "Cancel", style: .Default, handler: { action in
			//
		})))
		self.presentViewController(actionSheet, animated: true, completion: nil)
		softReset()
	}
	
	func showCamera(){
		let cameraPicker = UIImagePickerController()
		cameraPicker.delegate = self
		cameraPicker.sourceType = .Camera
		presentViewController(cameraPicker, animated: true, completion: nil)
	}
	
	func showAlbum(){
		let cameraPicker = UIImagePickerController()
		cameraPicker.delegate = self
		cameraPicker.sourceType = .PhotoLibrary
		presentViewController(cameraPicker, animated: true, completion: nil)
	}
	
	@IBAction func filterButton(sender: UIButton) {
		if (sender.selected){
			hideSecondMenu()
			sender.selected = false
		} else{
			showSecondMenu()
			sender.selected = true
		}
	}
	
	func showSecondMenu(){
		self.view.addSubview(SecondMenu)
		
		let bottomConstraint = SecondMenu.bottomAnchor.constraintEqualToAnchor(firstMenu.topAnchor)
		let leftConstraint = SecondMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
		let rightConstraint = SecondMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
		let heightConstraint = SecondMenu.heightAnchor.constraintEqualToConstant(88)
		NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
		view.layoutIfNeeded()
		
		UIView.animateWithDuration(0.5){
			self.SecondMenu.alpha = 0.75
		}
		
	}
	
	func hideSecondMenu(){
		UIView.animateWithDuration(0.5, animations: {
			self.SecondMenu.alpha = 0
		}) {_ in
			self.SecondMenu.removeFromSuperview()
		}
		
		self.currentFilter = "Identity"
		self.currentParameter = "1"
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.filterSlider.enabled = false
		self.filterButtonLabel.selected = false
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		onNewLabel.setImage(UIImage(named:"NewPhoto"), forState: UIControlState.Normal)
		onShareLabel.setImage(UIImage(named:"Share"), forState: UIControlState.Normal)
		socialLabel.setImage(UIImage(named:"Share"), forState: UIControlState.Normal)
		filterButtonLabel.setImage(UIImage(named:"Filter"), forState: UIControlState.Normal)
		filterButtonLabel.setImage(UIImage(named:"Filter"), forState: UIControlState.Selected)
		compareButton.setImage(UIImage(named:"Compare"), forState: UIControlState.Normal)
		compareButton.setImage(UIImage(named:"Compare"), forState: UIControlState.Normal)
		
		brightButtonLabel.setImage(UIImage(named:"bright"), forState: UIControlState.Normal)
		contrastButtonLabel.setImage(UIImage(named:"contrast"), forState: UIControlState.Normal)
		gammaButtonLabel.setImage(UIImage(named:"gamma"), forState: UIControlState.Normal)
		greyscaleButtonLabel.setImage(UIImage(named:"greyscale"), forState: UIControlState.Normal)
		solarisationButtonLabel.setImage(UIImage(named:"solarisation"), forState: UIControlState.Normal)
		inversionButtonLabel.setImage(UIImage(named:"inversion"), forState: UIControlState.Normal)
		redButtonLabel.setImage(UIImage(named:"red"), forState: UIControlState.Normal)
		greenButtonLabel.setImage(UIImage(named:"green"), forState: UIControlState.Normal)
		blueButtonLabel.setImage(UIImage(named:"blue"), forState: UIControlState.Normal)
		scaleButtonLabel.setImage(UIImage(named:"resize"), forState: UIControlState.Normal)
		alphaButtonLabel.setImage(UIImage(named:"alpha"), forState: UIControlState.Normal)
		
		SecondMenu.translatesAutoresizingMaskIntoConstraints = false
		SecondMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.25)
		
		self.lastSavedImage = UIImage(named: "landscape")!
		self.filteredImageView.image = UIImage(named: "landscape")
		
		self.filterSlider.minimumValue = -128
		self.filterSlider.maximumValue = 127
		self.filterSlider.continuous = false
		
		softReset()
	}
	
	@IBAction func filterSliderValue(sender: UISlider) {
		let value = Int8(round(sender.value / 1) * 1)
		self.currentParameter = String(value)
		filterIt()
	}
	
	@IBAction func onSaveDown(sender: AnyObject) {
		self.lastSavedImage = self.filteredImageView.image!
		UIView.animateWithDuration(1){
			self.infoLabel.text = "Saving as new base image!"
		}
	}
	
	@IBAction func onSaveUp(sender: UIButton) {
		self.infoLabel.text = "Saved as new base image!"
		compareButton.enabled = false
	}
	
	func softReset(){
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		self.infoLabel.text = ""
		self.infoLabel.hidden = false
		self.compareButton.enabled = false
		hideSecondMenu()
	}
	
	
	@IBOutlet weak var onSaveLabel: UIButton!
	
	@IBAction func greyscaleButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		filterSlider.enabled = false
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Greyscale"
		filterIt()
	}
	
	@IBAction func redButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Red"
		self.filterSlider.enabled = true
	}
	
	@IBAction func greenButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Green"
		self.filterSlider.enabled = true
		
	}
	
	@IBAction func blueButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Blue"
		self.filterSlider.enabled = true
	}
	
	@IBAction func alphaButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Alpha"
		self.filterSlider.enabled = true
	}
	
	@IBAction func brightButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Bright"
		self.filterSlider.enabled = true
	}
	
	@IBAction func contrastButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Contrast"
		self.filterSlider.enabled = true
	}
	
	@IBAction func gammaButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Gamma"
		self.filterSlider.enabled = true
	}
	
	@IBAction func solarisationButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Solarisation"
		self.filterSlider.enabled = true
	}
	
	@IBAction func inversionButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.filterSlider.enabled = false
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Inversion"
		filterIt()
	}
	
	@IBAction func scaleButton(sender: UIButton) {
		self.infoLabel.text = ""
		self.filteredImage = self.lastSavedImage
		self.filteredImageView.image = self.filteredImage
		
		self.sliderValue.text = "1"
		self.filterSlider.setValue(1, animated: true)
		self.currentFilter = "Scale"
		self.filterSlider.enabled = true
	}
	
	func filterIt() {
		let filteringCommand = self.currentFilter + " " + self.currentParameter
		
		self.sliderValue.text = filteringCommand

		let myPipeline = Workflow(withSequence: workflowInterface(filteringCommand))
		
		if myPipeline != nil {
			print("Could create the pipeline")
			if myPipeline!.somethingWentWrong{
				print("...but there were some problems: check spelling...")
			}
			myPipeline!.apply(self.lastSavedImage)
		} else{
			print("Could not create pipeline")
		}
		self.filteredImage = myPipeline!.result!
		self.filteredImageView.image = self.filteredImage
		
		self.compareButton.enabled = true
		
		self.infoLabel.text = "Applied: '" + self.currentFilter + " " + self.currentParameter + "'"
		replaceWithFiltered()
	}
	
	func replaceWithOriginal(){
		UIView.animateWithDuration(1){
			UIView.transitionWithView(self.filteredImageView,
			                          duration:5,
			                          options: UIViewAnimationOptions.TransitionCrossDissolve,
			                          animations: {
										self.filteredImageView.image = self.lastSavedImage},
			                          completion: nil)
		}
	}
	
	func replaceWithFiltered(){
		UIView.animateWithDuration(1){
			UIView.transitionWithView(self.filteredImageView,
			                          duration:5,
			                          options: UIViewAnimationOptions.TransitionCrossDissolve,
			                          animations: {
										self.filteredImageView.image = self.filteredImage},
			                          completion: nil)
		}
	}
	
	@IBAction func compareButtonDown(sender: UIButton) {
		self.infoLabel.text = "Last saved image"
		replaceWithOriginal()
	}
	
	@IBAction func compareButtonUp(sender: UIButton) {
		self.infoLabel.text = "Current image"
		replaceWithFiltered()
	}
	
	@IBOutlet var tap1Recogniser: UILongPressGestureRecognizer!
	@IBAction func onTap1(sender: UILongPressGestureRecognizer) {
		switch sender.state {
		case .Began:
			compareButtonDown(UIButton())
		case .Ended:
			compareButtonUp(UIButton())
		default:
			break
		}
	}
	
	@IBOutlet var tap2Recogniser: UITapGestureRecognizer!
	@IBAction func onTap2(sender: UITapGestureRecognizer) {
		print("2tap")
		self.imageScrollView.setZoomScale(self.imageScrollView.zoomScale * 2.0, animated: true)
	}
	
	@IBOutlet var tap3Recogniser: UITapGestureRecognizer!
	@IBAction func onTap3(sender: UITapGestureRecognizer) {
		print("3tap")
		self.imageScrollView.setZoomScale(self.imageScrollView.zoomScale / 2.0, animated: true)
	}
	
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
		return self.filteredImageView
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if (segue.identifier == "toSocial") {
			print("Preparing segue toSocial")
			let destination = segue.destinationViewController
		}
		else{
			print("Some other segue")
		}
	}
	
}


	
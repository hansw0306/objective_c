//
//  ViewController.h
//  AppTestObj
//
//  Created by SANGWON HAN on 16/03/2020.
//  Copyright © 2020 SANGWON HAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/*
 @property (


 atomic OR nonatomic
 이 두 속성중 하나를 선택하는 것으로 기본값은 atomic입니다. 이부분은 멀티스레딩에 관련된 부분으로 보통 nonatomic을 사용합니다. 자세한건 개발자 문서 참고

 assign(양수) OR retain OR copy
 setter에서 객체를 지정 받을때
 assign의 경우 주소값만 지정받고
 retain의 경우 기존것을 release후 새로 받은걸 retain합니다.
 copy의 경우 기존것을 release후 새로 받은걸 copy합니다.
 이부분은 setter에 관련있고 getter와는 관련 없습니다.
 
 readonly OR 없음
 readonly설정되면 setter가 없습니다. 말그대로 읽기 전용이죠

 -설명
 https://blog.outsider.ne.kr/604
 */
@end


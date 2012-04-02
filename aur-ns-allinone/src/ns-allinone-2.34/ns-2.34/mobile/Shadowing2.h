/*=============================================================================
#     FileName: Shadowing2.h
#         Desc: 
#       Author: quake0day
#        Email: quake0day@gmail.com
#     HomePage: http://www.darlingtree.com
#      Version: 0.0.1
#   LastChange: 2012-04-02 11:17:04
#      History:
=============================================================================*/
#ifndef SHADOWING2_H_
#define SHADOWING2_H_


/********* include files *****************************************************/

#include "shadowing.h"


/********* class declaration *************************************************/

/** Add calculation of maximum Receiving Distance (distCST_ ) to
 *  Shadowing-Model. Therefor the value validity_ defines the propability
 *  that for the maximum distance the receiving power is greater than CSThresh_
 */
class Shadowing2 : public Shadowing {
public:
	virtual double getDist(double Pr, double Pt, double Gt, double Gr,
			       double hr, double ht, double L, double lambda);

	Shadowing2();

	double validity_;
};

#endif //SHADOWING2_H_

